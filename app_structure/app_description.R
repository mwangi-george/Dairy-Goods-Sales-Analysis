app_description = div(
  class = "dashboard_description_page",
  h2(strong("Dairy Goods Sales Dashboard"), style = "margin-bottom: 15px;"),
  p(
    "The utilization of RShiny offers a remarkable opportunity for the creation of tailored analytics dashboards, overcoming the constraints of conventional BI tools.     Unlike mainstream BI tools like Power BI or Tableau, which offer limited customization options, RShiny, rooted in the R programming language, provides
    unparalleled flexibility and customization capabilities. As the developer of this dashboard, I leveraged R's extensive libraries and JavaScript functionalities to
    craft highly personalized and interactive visualizations. This endeavor aimed to empower users with greater control over the aesthetics and functionalities of
    their visual data representations."
  ),
  p(
    "Despite having only a year of experience in R programming at the time of developing this Dashboard, I embarked on this project to demonstrate the prowess of
  Shiny. It's worth noting that during its development, I was still navigating the implementation of best practices in the development process, acknowledging that
  growth often begins from a place of learning and experimentation."
  ),
  h4(
    strong("Data Acquisition and Exploration")
  ),
  p(
    "The first step involved sourcing a comprehensive dataset that encompassed diverse features such as numeric variables, categorical variables, and time
    series aspects. After approximately two hours of research across platforms like GitHub and Kaggle, I discovered a suitable dataset available at this",
    a("Kaggle link.", href = "https://www.kaggle.com/datasets/suraj520/dairy-goods-sales-dataset", target = "_blank"), "This dataset contains detailed information on dairy farms,
    products, sales, and inventory tracking in different locations in India. Subsequently, I dedicated time to thoroughly explore the dataset, a pivotal phase in any analytics project, enabling a
    comprehensive understanding of the data through descriptive statistics, charts, and tests."
  ),
  h4(
    strong("Leveraging R's Strengths")
  ),
  p(
    "R's unparalleled strength in conveying analytical findings prompted me to use Shiny to communicate these results interactively. While alternatives like
    Quarto or Rmarkdown could generate reports in PDF, Word Doc, or HTML formats, Shiny emerged as the optimal choice for delivering an immersive, interactive user
    experience."
  ),
  h4(
    strong("What did Shiny offer?")
  ),
  p(
    "The dashboard harnesses the full potential of Shiny, providing an array of interactive elements. Each visual or table is highly interactive, maximizing user engagement. The dashboard includes maximizable boxes, downloadable charts and tables, dual sidebars (left and controlbar on the right), custom sidebars housing slicers for specific plots, time series plots integrated with range selectors, customizable navbar and sidebar colors through the controlbar skin tab, support for embedding external links, and a convenient dark mode. Navigation within the dashboard is facilitated via the left sidebar, while the controlbar enables users to toggle and modify dashboard inputs as desired.
"
  ),
  h4(
    strong("What did I learn?")
  ),
  p(
    "Developing this Shiny app marked a significant transition as it made me realize that building a Shiny app is akin to stepping into the domain of software development. Embracing this shift prompted me to adopt crucial software development best practices like: writing clear and maintainable code, emphasizing documentation, minimizing code duplication, adopting version control, adhering to consistent style guides, and advocating for design before implementation."
  ),
  p(
    "A pivotal learning moment was the adoption of modularization through Shiny modules. Previously, I would consolidated all code within the app.R file, leading to confusion and inefficiency as the app expanded. Embracing Shiny modules allowed me to break down the application into manageable pieces, enhancing organization, reusability, and maintainability."
  ),
  p(
    "Additionally, I acquired some basic proficiency in utilizing the JavaScript",
    a("Highcharts library", href = "https://www.highcharts.com/demo", target = "_blank"), "for interactive data visualization in R, facilitated by its wrapper, the highcharter R package. The familiarity of its syntax, akin to ggplot2, eased the transition and allowed for seamless generation of interactive graphics with the added feature of exporting in various formats."
  ),
  h4(
    strong("What next after this?")
  ),
  p(
    "This project was huge achievement for me due to the things it opened my eyes to. I had to do a lot of research, which led to me finding out about a shiny
application framework called", a("rhino", href = "https://appsilon.github.io/rhino/", target = "_blank"), "developed by",
    a("Appsilon.", href = "https://appsilon.com/", target = "_blank"), "Moving forward, I aspire to employ the rhino framework and the associated", a("rhinoverse", href = "https://rhinoverse.dev/#rhino", target = "_blank"), "packages in upcoming projects, recognizing the efficiencies and advanced features these frameworks offer. Furthermore, this project illuminated the significance of Continuous Integration/Continuous Deployment (CI/CD) techniques, a facet I aim to integrate into future projects to automate data extraction, testing, and deployment processes using tools like GitHub Actions for real-time data applications. It's amazing how much this project exposed me to."
  ),
  p("For those interested in accessing the source code for this project, please feel free to reach out to me", a("here.", href = "https://www.twitter.com/mwangi__george", target = "_blank"))
)
