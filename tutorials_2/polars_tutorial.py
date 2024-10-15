#import libraries
import polars as pl

#import data
df = pl.read_csv("Amphibians.csv")
print(df)

#create a new dataframe
names = pl.Series("name", ["Dad", "Mom", "Katelyn", "Spencer", "Hannah", "Austin", "Noah", "Josh"])
age = pl.Series("age", [58, 56, 35, 33, 30, 28, 25, 23])
fav_nut = pl.Series("favorite_nut", ["Walnut", "Pistachio", "Almond", "Pecan", "Peanut", "Hazelnut", "Cashew", "Macadamia"])

family_df = pl.DataFrame([names, age, fav_nut])
print(family_df)

#add a new column
gender = pl.Series(["Male", "Female", "Female", "Male", "Female", "Male", "Male", "Male"])
family_df = family_df.with_columns(Gender = pl.lit(gender))
print(family_df)

#drop a column
family_df = family_df.drop("favorite_nut")
print(family_df)

#drop duplicate rows
mario_char = pl.DataFrame({
    "Name": ["Mario", "Luigi", "Wario", "Mario", "Mario", "Luigi"],
    "Age": [30, 28, 26, 30, 30, 28]
})
print(mario_char)

mario_char_unique = mario_char.unique()
print(mario_char_unique)


#iterating polars dataframe
print(mario_char)

for row in mario_char.rows():
    print(row)


#plot polars dataframe
import matplotlib.pyplot as plt
import polars as pl

prices_df = pl.DataFrame({
    "Date": ["1/1/2023", "1/2/2023", "1/3/2023", "1/4/2023", "1/5/2023", "1/6/2023", "1/7/2023", "1/8/2023", "1/9/2023", "1/10/2023"],
    "Price": [15, 16, 16, 15, 14, 13, 14, 17, 16, 18]
})

print(prices_df)

dates = prices_df["Date"].to_list() 
prices = prices_df["Price"].to_list()

#plotting
plt.plot(dates, prices)
plt.xlabel("Date")
plt.ylabel("Price")
plt.title("Price Over Time")
plt.xticks(rotation = 45)
plt.show()


#filtering
print(prices_df)
filtered = prices_df.filter((prices_df["Price"] > 15) &
                            (prices_df["Price"] < 17)
)
print(filtered)


#joining polars dataframes
import polars as pl

df1 = pl.DataFrame({
    "key": ["A", "B", "C", "D"],
    "value_left": [1, 2, 3, 4]
})

df2 = pl.DataFrame({
    "key": ["B", "C", "D", "E"],
    "value_right": [5, 6, 7, 8]
})

joined_df = df1.join(df2, on = "key")
joined_df_left = df1.join(df2, on = "key", how = "left")
print(df1)
print(df2)
print(joined_df)
print(joined_df_left)


#aggregate data
import polars as pl
calories_df = pl.DataFrame({
    "Name": ["Chris", "Chris", "Kyle", "John", "John", "Chris", "Kyle"],
    "Calories": [100, 200, 50, 100, 350, 150, 450]
})
print(calories_df)

calories_sum = calories_df.group_by(["Name"]).agg(
    sum_ = pl.col("Calories").sum(),
    count_ = pl.col("Calories").count()
)
print(calories_sum)


#sorting dataframes
print(calories_df)
sorted_df = calories_df.sort(["Name", "Calories"], descending = [False, True])
print(sorted_df)


#renaming columns
print(calories_df.rename({
    "Name":"Person",
    "Calories":"Calories Burned"
}))



#select columns
print(mario_char)
print(mario_char.select("Name"))



#fill/drop null values
df3 = pl.DataFrame({
    "Name": ["John", "Steven", "Chris", None],
    "Age": [20, 25, None, 32],
    "Score": [99, None, 100, None]
})
print(df3)
print(df3.fill_null("NULL_STRING").fill_null(0))
print(df3.drop_nulls())



#convert string to date
print(prices_df)
prices_df = prices_df.with_columns(Date = prices_df["Date"].str.to_date())
print(prices_df)


#change column type
print(prices_df.with_columns(Price = prices_df["Price"].cast(str)))


#shift values
print(calories_df)
print(calories_df.with_columns(Shifted = calories_df["Calories"].shift(2).fill_null(0)))


#export dataframe to csv
calories_df.write_csv("calories_df.csv")


#Polars data manipulation practice -------------------------------------------------------------------------------------------------

#Scenario 2 ----------------
family_df = pl.DataFrame({
    "Name": ["Dad", "Mom", "Katelyn", "Spencer", "Hannah", "Austin", "Noah", "Josh"],
    "Age": [58, 56, 35, 33, 30, 28, 25, 23],
    "Favorite_Nut": ["Walnut", "Pistachio", "Almond", "Pecan", "Peanut", "Hazelnut", "Cashew", "Macadamia"]
})

#Add a new column to the DataFrame with the gender of each family member
genders = pl.Series(["Male", "Female", "Female", "Male", "Female", "Male", "Male", "Male"])
family_df = family_df.with_columns(gender = pl.lit(genders))
print(family_df)

#Sort the DataFrame by favorite nut
print(family_df.sort("Favorite_Nut"))


#scenario 3 ---------------------
nintendo = pl.DataFrame({
    "Name": ["Mario", "Luigi", "Peach", "Bowser", "Donkey Kong", "Cranky Kong", "Kamek", "Peach"],
    "Age": [25, 25, 23, 30, 20, 40, 50, 23]
    })
print(nintendo)

#Filter the characters who are older than 28 and store them in a new DataFrame. How many rows are in the new DataFrame?
nintendo_old = nintendo.filter(nintendo["Age"] > 28)
nintendo_old.count()

#Remove duplicates from the DataFrame
print(nintendo.unique())



#Scenario 4 -------------------------
import polars as pl

stocks = pl.DataFrame({
    "Date": ["1/1/2023", "1/2/2023", "1/3/2023", "1/4/2023", "1/5/2023", "1/6/2023", "1/7/2023", "1/8/2023", "1/9/2023", "1/10/2023"],
    "Price": [15, 16, 16, 15, 14, 13, 14, 17, 16, 18]
})
print(stocks)

#Convert the Date column from string format to a date format and plot the stock price over time using matplotlib.
stocks2 = stocks.with_columns(Date = stocks["Date"].str.to_date())
print(stocks2)

import matplotlib.pyplot as ply

dates = stocks["Date"].to_list()
prices = stocks["Price"].to_list()

ply.plot(dates, prices)
ply.show()

#Filter the prices to include only the dates where the price was between 15 and 17. Show the filtered DataFrame and plot these values.
print(stocks2.filter((stocks2["Price"] >= 15) & 
                     (stocks2["Price"] <= 17))
)