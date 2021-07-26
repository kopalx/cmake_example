
# %%
import cmake_example as m

# %%
assert m.__version__ == "0.0.1"
assert m.add(1, 2) == 3
assert m.subtract(1, 2) == -1

# %%
p = m.Pet('Molly')
print(p)
p.getName()

# %%
p.setName('Charly')
p.getName()
# %%
