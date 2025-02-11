library(readr)
library(tidyverse)
library(pdftools)
library(stringr)
library(stringi)
library(ggrepel)
library(showtext)
library(ggthemes)
library(sysfonts)

# Extract text from the PDF
lotr_text <- pdf_text("C:/Users/austi/OneDrive/Desktop/R/R-Sandbox/data/lotr_text_full.pdf")
lotr_text_full <- lotr_text |> 
  paste(collapse = " ") |> 
  tolower() |> 
  stri_trans_general("Latin-ASCII") |> 
  str_squish() |> 
  str_remove(".*elder days in middle-earth") |> 
  str_remove("appendix a annals of the kings.*")
  
view(lotr_text_full)


# finding names -----------------------------------------------------------

# Function to replace all names with cannonical names using the mapping
replace_with_canonical <- function(text, mapping) {
  for (i in 1:nrow(mapping)) {
    pattern <- str_c("\\b(", str_replace_all(mapping$names[i], ",", "|"), ")\\b", collapse = "")
    text <- str_replace_all(text, pattern, mapping$canonical_name[i])
  }
  return(text)
}

#function to count occurrences of each character's name
count_occurrences <- function(character, text) {
  str_count(text, fixed(character))
}

# data frame mapping all names to their canonical names
name_mapping <- data.frame(
  canonical_name = c("gollum", "aragorn", "gandalf", "sam", "merry", "pippin", "sauron", "saruman", "nazgul",
                     "galadriel", "wormtongue", "balrog", "witch-king", "radagast",
                     "king of the dead", "celeborn"),
  names = c("gollum,smeagol", "aragorn,strider,elessar,estel", "gandalf,mithrandir,olorin,grey pilgrim", "sam,samwise",
            "merry,meriadoc", "pippin,peregrin took", "sauron,dark lord,necromancer", "saruman,curunir", 
            "nazgul,ringwraith,black rider", "galadriel,lady of lothlorien,lady of the wood", "wormtongue,grima", "balrog,durin's bane", 
            "witch-king,witch-lord,shadow of angmar,king of angmar,lord of the nazgul,pale king,black captain,wraith-lord",
            "radagast,aiwendil", "king of the dead,king of the mountain,rioc", "celeborn,teleporno"),
  stringsAsFactors = FALSE
)

# Apply the replacement function to cannonize all names
lotr_text_full_cannonized_names <- replace_with_canonical(lotr_text_full, name_mapping)


#create character list
characters <- c("frodo", "sam", "gandalf", "aragorn", "legolas", 
                "gimli", "boromir", "merry", "pippin", "gollum", 
                "sauron", "saruman", "faramir", "denethor", "eowyn", 
                "theoden", "nazgul", "bilbo", "bombadil", "glorfindel", 
                "elrond", "arwen", "galadriel", "wormtongue", "shadowfax", 
                "treebeard", "shelob", "eomer", "balrog", "witch-king", 
                "radagast", "haldir", "gothmog", "king of the dead", "isildur",
                "celeborn", "rosie cotton", "gamling", "hama")

# Apply the function
name_counts <- sapply(characters, count_occurrences, text = lotr_text_full_cannonized_names)
name_counts_df <- data.frame(character = characters, count = name_counts)


# screen time -------------------------------------------------------------

screen_time <- data.frame(
  character = c("frodo", "sam", "gandalf", "aragorn", "legolas", 
                "gimli", "boromir", "merry", "pippin", "gollum", 
                "sauron", "saruman", "faramir", "denethor", "eowyn", 
                "theoden", "bilbo", "bombadil", "glorfindel", 
                "elrond", "arwen", "galadriel", "wormtongue", "shadowfax", 
                "treebeard", "shelob", "eomer", "balrog", "witch-king", 
                "radagast", "haldir", "gothmog", "king of the dead", "isildur",
                "celeborn", "rosie cotton", "gamling", "hama"),
  screen_time = c(123.933, 80.5833, 88.3667, 96.1667, 47.9333,
                  19.85, 25.9, 36.2167, 45.6833, 42.4167,
                  4, 10.9667, 14.8167, 7.6833, 21.9667,
                  31.65, 13.6, 0, 0.5,
                  15.0833, 18.6167, 11.4833, 7.1, 4,
                  10, 3.5, 13.3667, 2.75, 6.6,
                  0, 3.5667, 3.5, 1.9167, 2.5,
                  1.4333, 1.5, 4, 2)
)


# join tables -------------------------------------------------------------

lotr_counts_screen <- name_counts_df |> 
  inner_join(screen_time, by = "character")

lotr_counts_screen$character <- str_to_title(lotr_counts_screen$character) 

lotr_counts_screen <- lotr_counts_screen |> 
  mutate(character = case_when(
    character == "Witch-King" ~ "Witch King",
    character == "Bombadil" ~ "Tom Bombadil",
    TRUE ~ character
  ))

# plotting ----------------------------------------------------------------

font_add("Ringbearer", "../fonts/RingbearerMedium-51mgZ.ttf")
showtext_auto()

lotr_counts_screen <- lotr_counts_screen |> 
  mutate(predicted = predict(lm(screen_time ~ count)),
         color = ifelse(screen_time > predicted, "OVER-represented in movies", "UNDER-represented in movies"))

model <- lm(filtered_characters$screen_time ~ filtered_characters$count)
intercept <- coef(model)[1]
slope <- coef(model)[2]

filtered_characters <- lotr_counts_screen |> 
  filter(!character %in% c("Rosie Cotton", "Shadowfax", "Balrog", "Hama", "Gamling", "Isildur", "King Of The Dead"))


ggplot(filtered_characters, aes(x = count, y = screen_time)) +
  geom_point(aes(), size = 3.5, alpha = 0.5) +
  scale_x_continuous(trans = "sqrt") +
  scale_y_continuous(trans = "sqrt") +
  #geom_smooth(method = "lm") +
  geom_abline(intercept = 1.06, slope = 0.227, linetype = "dotted", size = 1) +
  geom_text_repel(aes(label = character), 
                  box.padding = 0.5,
                  point.padding = 0.4,
                  label.padding = 0.18,
                  min.segment.length = 0.45,
                  force = 0.5,
                  segment.color = "grey50",
                  segment.size = 0.75,
                  size = 3.8,
                  family = "Ringbearer"
  ) +
  scale_color_manual(values = c("OVER-represented in movies" = "firebrick", 
                                "UNDER-represented in movies" = "navyblue")) +
  theme_minimal() +
  theme(legend.position = "none",
        plot.title = element_text(size=45, face="bold", hjust = 0.5,
                                  margin = margin(15, 0, 15, 0))) +
  ggtitle("Lord of the Rings Characters") +
  theme(
    plot.title = element_text(family = "Ringbearer", size = 40, face = "bold"),
    #axis.text = element_blank(),
    axis.text.x = element_text(angle = 0, size = 8, vjust = 4),
    axis.text.y = element_text(angle = 0, size = 8, vjust = 1),
    axis.title.x = element_text(vjust = 0, size = 15),
    axis.title.y = element_text(vjust = 0, size = 15),
    panel.grid = element_blank(),
    panel.background = element_rect(fill = "#fbfbf0", color = "#fbfbf0"),
    plot.background = element_rect(fill = "#fbfbf0")
  ) +
  labs(
    x = "Number of Mentions in Books",
    y = "Screen Time in Films (minutes)",
    color = "",
    caption = "Source: The Lord of the Rings, @Matthew Stewart"
  ) +
  annotate("text", 
           x = 100, y = 85, 
           label = "OVER represented \nin movies", 
           color = "firebrick", 
           size = 6,
           family = "Ringbearer") +
  annotate("text", 
           x = 1300, y = 10, 
           label = "UNDER represented \nin movies", 
           color = "navyblue", 
           size = 6,
           family = "Ringbearer")


cor(lotr_counts_screen$count, lotr_counts_screen$screen_time)
