file = open('data.csv', 'w')
for i in range(102):
    file.write('{},{}\n'.format(i, i + 2))
file.close()