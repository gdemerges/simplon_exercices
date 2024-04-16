import dash
from dash import html, dcc, Input, Output
import plotly.express as px
import pandas as pd
import dash_bootstrap_components as dbc

DATA_FILE = './data/Food_Production.csv'
PORT = 8080
DEBUG_MODE = True

external_stylesheets = ['assets/style.css', dbc.themes.BOOTSTRAP]

data = pd.read_csv(DATA_FILE)

app = dash.Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])

# App layout
app.layout = dbc.Container([
    html.H1("Analyse de l'impact environnemental de la production alimentaire", className='text-center mb-4'),
    dbc.Row([
        dbc.Col([
            dbc.Card([
                dbc.CardBody([
                    html.Label('Sélectionnez les produits alimentaires :', className='h5'),
                    dcc.Dropdown(
                        id='product-dropdown',
                        options=[{'label': product, 'value': product} for product in data['Food product'].unique()],
                        value=data['Food product'].unique().tolist(),
                        multi=True,
                        style={'width': '100%'}
                    )
                ])
            ])
        ], width=12)
    ]),
    dbc.Row([
        dbc.Col([
            dbc.Card([
                dbc.CardHeader("Emissions par Phase"),
                dbc.CardBody([
                    dcc.Graph(id='emissions-by-phase-bar')
                ])
            ], className="mb-4")
        ], md=12),
        dbc.Col([
            dbc.Card([
                dbc.CardHeader("Sources d'Eau"),
                dbc.CardBody([
                    dcc.Graph(id='water-source-pie')
                ])
            ], className="mb-4")
        ], md=6),
        dbc.Col([
            dbc.Card([
                dbc.CardHeader("Emissions de GES"),
                dbc.CardBody([
                    dcc.Graph(id='ghg-emissions-boxplot')
                ])
            ], className="mb-4")
        ], md=6)
    ])
], fluid=True)


# Callback for bar chart
@app.callback(
    Output('emissions-by-phase-bar', 'figure'),
    Input('product-dropdown', 'value')
)
def update_bar_chart(selected_products):
    filtered_data = data[data['Food product'].isin(selected_products)]
    fig = px.bar(filtered_data, x='Food product', y=['Land use change', 'Animal Feed', 'Farm', 'Processing', 'Transport', 'Packging', 'Retail'],
        labels={'value': 'Emissions (kg CO₂eq)', 'variable': 'Phase de Production'}, barmode='stack')
    return fig

# Callback for pie chart
@app.callback(
    Output('water-source-pie', 'figure'),
    Input('product-dropdown', 'value')
)
def update_pie_chart(selected_products):
    filtered_data = data[data['Food product'].isin(selected_products)]
    fig = px.pie(filtered_data, values='Freshwater withdrawals per kilogram (liters per kilogram)', names='Food product',
                    hole=0.3)
    fig.update_layout(width=800, height=600, legend=dict(
            x=-0.2,
            y=1,
            xanchor='left',
            yanchor='top'
        ),
        )

    fig.update_traces(textposition='inside', textinfo='percent+label')
    return fig

# Callback for boxplot
@app.callback(
    Output('ghg-emissions-boxplot', 'figure'),
    Input('product-dropdown', 'value')
)
def update_box_plot(selected_products):
    filtered_data = data[data['Food product'].isin(selected_products)]
    fig = px.box(filtered_data, y='Total_emissions', x='Food product', color='Food product')
    return fig

if __name__ == '__main__':
    app.run_server(debug=DEBUG_MODE, port=PORT)
