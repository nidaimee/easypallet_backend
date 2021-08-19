# Test EasyPallet (Backend)

<table>
  <tr>
    <td>Ruby version</td>
    <td>
      3.0.2
    </td>
  </tr>
  <tr>
    <td>Rails version</td>
    <td>
      6.0.x
    </td>
  </tr>
  <tr>
    <td>Database</td>
    <td>
     PostgreSQL
    </td>
  </tr>
</table>

## Initial settings to run the project

```bash
# clone the project
git clone https://github.com/nidaimee/easypallet_backend.git

# enter the cloned directory
cd easypallet_backend

# install Ruby on Rails dependencies
bundle install

# Build docker-compose
docker-compose build

# create the development and test databases
docker-compose run web rake db:create

# create the tables
docker-compose run web rake db:migrate

# run the project
docker-compose up

The backend is available at `http://localhost:3000`.

## Tests

To run the tests:

```bash
docker-compose run web bundle exec rspec 
```
### Test API with Postman

```bash
curl --location --request POST 'localhost:3000/api/v1/imports/csv' \
--form 'file=@"/home/raphael/Downloads/EASY PALLET - DESAFIO RUBY - Página1.csv"'
```

