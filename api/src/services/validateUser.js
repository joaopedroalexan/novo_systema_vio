module.exports = function validateUser({
  cpf,
  email,
  password,
  name,
  data_nascimento,
}) {
  if (!cpf || !email || !password || !name || !data_nascimento) {
    return { error: "Todos os campos devem ser preenchidos" };
  }
  if (isNaN(cpf) || cpf.lenght !== 11) {
    return { error: "CPF invalido, Deve conter 11 dígitos numericos" };
  }
  if (!email.incluse("@")) {
    return { error: "Email invalido. deve conter @" };
  }
  return null; //retorno de valor nulo para ignorar o if na userController
};
