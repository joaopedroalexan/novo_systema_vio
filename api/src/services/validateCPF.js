const connect = require("../db/connect");

module.exports = async function validateCPF(cpf, userId) {
  const query = "SELECT id_usuario FROM usuario WHERE cpf=?";
  const values = [cpf];

  await connect.query(query, values, (err, results) => {
    if (err) {
    } else if (results.length > 0) {
      const cpfCadastrado = results[0].id_usuario;

      if (userId && cpfCadastrado !== userId) {
        return {error: "CPF ja cadastrado para outro usuario"};
      } else if (!userId) {
        return { error: "CPF ja cadastrado" };
      }
    } else {
      return null;
    }
  });
};
