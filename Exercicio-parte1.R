# Na análise de concessão de empréstimos, uma variável potencialmente
# importante é a renda da pessoa. O gerente de um banco coleta uma base de
# dados de seus correntistas e extrai a variável “renda mensal (R$)” para 50
# pessoas. Embora se trate de uma variável quantitativa, deseja realizar uma
# análise por meio de tabela de frequências. Neste sentido, pede-se:

# a) Classifique os correntistas em faixas de renda, sendo: 0-2.000; 2.001-4.000;
# 4.001-6.000; 6.001-8.000; 8.001-10.000 e 10.001-12.000

# install.packages("readxl")

library(readxl)
library(tidyverse)

base <- readxl::read_excel("./excel/Lista de Exercicios - Complementaresxlsx Portugues.xlsx", 
                           sheet = "Exercício 1", range = cellranger::cell_cols("A:B") ) |>
       dplyr::arrange(`Renda (R$)`)

#Criando as faixas de acordo com a renda


base <- base |> 
  dplyr::mutate(
    Faixa_Renda =
      dplyr::case_when(
                       dplyr::between(`Renda (R$)`,0,2000) ~ "0-2000",
                       dplyr::between(`Renda (R$)`,2001,4000) ~ "2001-4000",
                       dplyr::between(`Renda (R$)`,4001,6000) ~ "4001-6000",
                       dplyr::between(`Renda (R$)`,6001,8000) ~ "6001-8000",
                       dplyr::between(`Renda (R$)`,8001,10000) ~ "8001-10000",
                       dplyr::between(`Renda (R$)`,10001,12000) ~ "10001-12000",
                       TRUE ~ "NA"
                       ) )

# b) Em seguida, elabore a tabela de frequências para as faixas de renda acima.


base_grouped <- base |> 
                dplyr::group_by(Faixa_Renda) |> 
                dplyr::summarise(freq_abs=dplyr::n())

library(ggplot2)

ggplot2::ggplot(base, aes(x=Faixa_Renda)) + 
  geom_bar() + 
  labs(title = "Contagem por Faixa de Renda", 
       x = "Faixa de Renda") + theme(axis.text.x = element_text(angle = 45, hjust = 1))
