#include "Parser/ConfigParser.hpp"
#include "Parser/WrongConfigException.hpp"
#include "Core.hpp"

int main(int argc, char* argv[]) {
	std::string name;
	if (argc == 1)
		name = "configs/webserv.conf";
	else {
		std::string fileName = argv[1];
		name = "configs/" + fileName;
	}
	ConfigParser parser(name);
	try {
		parser.launchConfig();
	} catch (WrongConfigException & e) {
		std::cerr << e.what() << std::endl;
		return 1;
	}
	try {
		Core core(parser.getServers());
		core.pollCycle();
	} catch (const std::exception & e) {
		std::cerr << "CoreException: " << e.what() << std::endl;
		return 1;
	}
	return 0;
}
