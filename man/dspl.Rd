% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dspl.r
\name{dspl}
\alias{dspl}
\alias{GooglePublicData}
\alias{dspl}
\alias{new_dspl}
\title{Builds Dataset Publication Language (DSPL) metadata file}
\usage{
dspl(path, output = NA, replace = F, targetNamespace = "",
  timeFormat = "yyyy", lang = c("es", "en"), name = NA,
  description = NA, url = NA, providerName = NA, providerURL = NA,
  sep = ";", dec = ".", encoding = getOption("encoding"),
  moreinfo = NULL)

new_dspl(path, output = NA, replace = F, targetNamespace = "",
  timeFormat = "yyyy", lang = c("es", "en"), name = NA,
  description = NA, url = NA, providerName = NA, providerURL = NA,
  sep = ";", dec = ".", encoding = getOption("encoding"),
  moreinfo = NULL)
}
\arguments{
\item{path}{String. Path to the folder where the tables (csv|tab|xls) are
at.}

\item{output}{String, optional. Path to the output ZIP file.}

\item{replace}{Logical. If \code{output} ZIP file is defined exists,
\code{dspl} replaces it.}

\item{targetNamespace}{String. As DSPL documentation states ``Provides a URI
that identifies your dataset. This URI is not required to point to an actual
resource, but it's a good idea to have the URI resolve to a document
describing your content or dataset''.}

\item{timeFormat}{String. The corresponding time format of the collection.
Should be specified accordingly to joda-time format. See the Details section
for more information.}

\item{lang}{A list of strings of the languages supported by the dataset.
Could be only one.}

\item{name}{List of strings. The name of the dataset as defined accordingly
to the \code{lang} list.}

\item{description}{List of strings. Description of the dataset. It also
supports multiple description as the \code{name}}

\item{url}{The corresponding URL for the dataset.}

\item{providerName}{List of strings. The data provider name.}

\item{providerURL}{List of strings. The data provider website url.}

\item{sep}{The separation character of the tables in the 'path' folder.
Currently supports introducing the following arguments: ``,'' or ``;'' (for
.csv files), ``\\t'' (for .tab files) and ``xls'' or ``xlsx'' (for Microsoft's
excel files).}

\item{dec}{String. Decimal point.}

\item{encoding}{The char encoding of the input tables. Currently ignored for
Microsoft excel files.}

\item{moreinfo}{A special tab file generated by the function
\code{\link{genMoreInfo}} that contains a dataframe of the dataset concepts
with more specifications such as description, topic, url, etc.}
}
\value{
If there isn't any \code{output} defined, \code{dspl} returns list
of \code{\link{class}} "\code{dspl}".

An object of class "\code{dspl}" is a list containing:
\item{dspl}{A character string containing the DSPL XML document as defined
by the \code{\link[XML:saveXML]{saveXML}} function.} 
\item{concepts.by.table}{A data frame object of concepts stored by table.} 
\item{dimtabs}{A data frame containing dimensional tables.} 
\item{slices}{A data frame of slices.} 
\item{concepts}{A data frame of concepts (all of them).}
\item{dimensions}{A data frame of dimensional concepts.}
\item{statistics}{A matrix of statistics.}

otherwise the function will build a ZIP file as specified in the output
containing the CSV and DSPL (XML) files.
}
\description{
Parsing \emph{csv}, \emph{tab} or \emph{xls(x)} files at a specific
directory path, dspl generates a complete DSPL file.  If an output string is
specified, the function generates the complete ZIP (DSPL file plus csv
files) ready to be uploaded to Google Public Data Explorer.
}
\details{
If there isn't any output defined the function returns a list of class
\code{dspl} that among its contents has a xml object (DSPL file); otherwise,
if an output is defined, the results consists on two things, an already ZIP
file containing a all the necessary to be uploaded at
\url{publicdata.google.com} (a collection of csv files and the XML DSPL
written file) and a message (character object).

Internally, the parsing process consists on the following steps:
\enumerate{
\item Loading the data, 
\item Generating each column corresponding id, 
\item Identifying the data types, 
\item Building concepts, 
\item Identifying dimensional concepts and distinguishing between categorical,
geographical and time dimensions, and
\item Executing internal checks.
}

In order to properly load the zip file (DSPL file plus CSV data files), the
function executes a series of internal checks upon the data structure. The
detailed list:
\itemize{
\item \strong{Slices with the same dimensions}: DSPL
requires that each slice represents one dimensional cut, this is, there
should not be more than one data table with the same dimensions.
\item \strong{Duplicated concepts}: As a result of multiple data types, e.g a single
concept (statistic) as integer in one table and float in other, \code{dspl}
may get confused, so during the parsing process, if there is a chance, it
collapses duplicated concepts into only one concept and assigns it the
common data type (float).
\item \strong{Correct time format definition}: Using \code{\link{checkTimeFormat}}
ensures that the time format specified is
compatible with DSPL.
}
}
\examples{

demo(dspl)
  

}
\references{
\itemize{ \item Google Public Data Explorer Tutorial:
\url{https://developers.google.com/public-data/docs/tutorial} }
}
\author{
George G. Vega Yon
}
\keyword{IO}
