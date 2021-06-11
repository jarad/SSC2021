# Functional input
library("tidyverse")

output = expand.grid(a = c(0.5,1,1.5),
                    b = c(0.5,1,1.5)) %>%
  mutate(y = rnorm(n(), a+b, 0.1))
                    
input = expand.grid(t = seq(0,2,length=11),
                a = unique(output$a),
                b = unique(output$b)) %>%
  mutate(f = a*exp(-b*t))

both = left_join(output, input, by = c("a","b")) %>%
  mutate(a = factor(a),
         b = factor(b),
         ab = paste0(a,b))
  

g = ggplot(both, aes(x = t, y = f, 
              color = y, group = ab)) + 
  geom_line() + 
  geom_point() +
  theme_bw() +
  scale_color_continuous(name = "Output") +
  labs(x = "Time, t", y = "Functional input, f(t)",
       title = "Example functional inputs")

ggsave(filename = "include/functional_input.jpeg", plot = g,
       width = 10, height = 8)                  
                