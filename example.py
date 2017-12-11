#!/bin/bash condavision 
import pandas as pd
import numpy
samples = pd.DataFrame(numpy.random.rand(3, 5))
print(samples.to_csv(index=False, header=False))