import streamlit as st

st.set_page_config(
    page_title="Streamlit Test",
    layout="centered"
)

st.title("Be Happy.")
if st.button("Press Button for Some Happiness"):
    st.success("You are amazing 😄")
if st.button("Reset"):
    st.write("")