import streamlit as st
import polars as pl
import pandas as pd
import plotly.express as px

st.set_page_config(
    page_title="LDS Membership Stats",
    page_icon="⛪",
    layout="centered",
    initial_sidebar_state="collapsed"
)

stats = pd.read_csv("lds_membership/lds_stats_clean.csv")

with st.expander("View Data"):
    st.dataframe(stats)
    
tab1, tab2 = st.tabs(["Single Metric", "Comparison"])

with tab1:     
    column_names = stats.columns.tolist()
    metric=st.selectbox("Choose a metric to view:", column_names)
    stats=stats.dropna(subset=[metric])

    fig = px.line(
        stats,
        x="year",
        y=metric
    )
    st.plotly_chart(fig)
    
with tab2: 
    st.write("Choose 2 metrics to compare:")
    
    col1, col2 = st.columns(2)
    with col1: 
        metric_1=st.selectbox("Metric 1:", column_names)
    with col2: 
        metric_2=st.selectbox("Metric 2:", column_names)
    
    fig_2 = px.line(
        stats,
        x="year",
        y=[metric_1, metric_2]
    )
    
    st.plotly_chart(fig_2)
