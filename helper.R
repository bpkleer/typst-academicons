# script to create overview and gallery file

# install package cssparser
# remotes::install_github('coolbutuseless/cssparser')

# download css file from github-repo
download.file(
  'https://github.com/jpswalsh/academicons/blob/master/css/academicons.css', 
  'academicons2.css',
   mode = 'wb'
  )

academicons <- cssparser::read_css('academicons.css')

academicons[4][[1]][[1]]

academicons[4]


stringr::str_detect(academicons[4][[1]][[1]], '\\\\e')

length(academicons)

names(academicons[4])

# new df for saving strings
helpdf <- data.frame(icon = character(), unicode = character())

j <-  1

for (i in 1:length(academicons)) {
  if (stringr::str_detect(academicons[i][[1]][[1]], '\\\\e')) {
    # getting icon name into helper df
    helper <- names(academicons[i]) |> 
      stringr::str_remove('.ai-') |> 
      stringr::str_remove(':before')
    
    # getting unicode into helper df
    helper <- c(helper, academicons[i][[1]][[1]] |> 
      stringr::str_remove_all('\\\\') |> 
      stringr::str_remove_all('\"')
    )
    
    helpdf <- rbind(helpdf, helper)

    helpdf[, 2][j] <- paste0('\\u{', helpdf[, 2][j], '}')

    j <- j + 1
  }
}

# creating string for typst
start <- '
#import "lib-impl.typ": ai-icon

// Generated icon list of Academicons 1.9.4

#let ai-icon-map = ('

write(start, file = 'lib-gen.typ')

# creating ai-icon-map
for (i in 1:dim(helpdf)[1]) {
  print(i)
  if (i == dim(helpdf)[1]) {
    transfer <- paste0('"', helpdf[, 1][i], '": "', helpdf[, 2][i], '")')

    write(transfer, file = 'lib-gen.typ', append = TRUE)
  } else {
    transfer <- paste0('"', helpdf[, 1][i], '": "', helpdf[, 2][i], '",')

    write(transfer, file = 'lib-gen.typ', append = TRUE)
  }
}

# creating each ai-icon 
for (i in 1:dim(helpdf)[1]) {
    transfer <- paste0('#let ai-', helpdf[, 1][i], ' = ai-icon.with("', helpdf[, 2][i], '")')

    write(transfer, file = 'lib-gen.typ', append = TRUE)
}


# Create gallery.typ
start <- '
#import "lib.typ": *
#table(columns: (2fr, 1fr, 1fr), stroke: none, table.header([typst code], [default], [`fa-icon` with text]),'

write(start, file = 'gallery.typ')

for (i in 1:dim(helpdf)[1]) {
  if (i == dim(helpdf)[1]) {
    transfer <- paste0(
      '```typst #ai-', helpdf[, 1][i], 
      '()```, ai-', helpdf[, 1][i],
      '(), ai-icon("', helpdf[, 1][i], '"),
      )'
    )

    write(transfer, file = 'gallery.typ', append = TRUE)

  } else {
    transfer <- paste0(
      '```typst #ai-', helpdf[, 1][i], 
      '()```, ai-', helpdf[, 1][i],
      '(), ai-icon("', helpdf[, 1][i], '"),'
    )

    write(transfer, file = 'gallery.typ', append = TRUE)
  }
}

transfer
