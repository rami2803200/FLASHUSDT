module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",  // Localhost
      port: 7545,         // Port Ganache is running on
      network_id: "5777", // Network ID for Ganache
    },
  },
  compilers: {
    solc: {
      version: "0.8.21",  // Specify the compiler version
    },
  },
};
