
NAME = webserv

CC = clang++
CFLAGS = -Wall -Werror -Wextra -MMD -std=c++98
# CFLAGS = -Wall -Werror -Wextra -g -std=c++98

MAIN = webserv
PARSER = ConfigParser Location ServerData WrongConfigException configUtils
HANDLER = HandlerException cgiHandler findLocation methodHandler
CORE = Core
REQUEST = Request
RESPONSE = Response

SRCS_DIR = ./srcs/
SRCS = $(addsuffix .cpp, $(MAIN)) \
	   $(addprefix Parser/, $(addsuffix .cpp, $(PARSER))) \
	   $(addprefix handler/, $(addsuffix .cpp, $(HANDLER))) \
	   $(addprefix Core/, $(addsuffix .cpp, $(CORE))) \
	   $(addprefix Request/, $(addsuffix .cpp, $(REQUEST))) \
	   $(addprefix Response/, $(addsuffix .cpp, $(RESPONSE)))

OBJS_DIR = ./objs/
OBJS_SUB = $(addprefix $(OBJS_DIR), Parser handler Core Request Response)
OBJS = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(MAIN))) \
	  $(addprefix $(OBJ_DIR), $(addsuffix .o, $(PARSER))) \
	  $(addprefix $(OBJ_DIR), $(addsuffix .o, $(HANDLER))) \
	  $(addprefix $(OBJ_DIR), $(addsuffix .o, $(CORE))) \
	  $(addprefix $(OBJ_DIR), $(addsuffix .o, $(REQUEST))) \
	  $(addprefix $(OBJ_DIR), $(addsuffix .o, $(RESPONSE)))

OBJS_BUILD = $(addprefix $(OBJS_DIR), $(SRCS:.cpp=.o))

CLASSES = -I srcs/Parser -I srcs/handler -I srcs/Core -I srcs/Request -I srcs/Response

DEPS	=	$(addprefix $(OBJ_DIR), $(OBJS_BUILD:.o=.d))

all: $(NAME)

$(NAME): $(OBJS_DIR) $(OBJS_BUILD)
		$(CC) $(CFLAGS) $(CLASSES) $(OBJS_BUILD) -o $(NAME)
		chmod +rx ./cgi-bin/names/names.py
		chmod +rx ./cgi-bin/textarea/textarea.py


$(OBJS_DIR)%.o: $(SRCS_DIR)%.cpp
				$(CC) $(CFLAGS) $(CLASSES) -c $< -o $@


$(OBJS_DIR):
			mkdir -p $(OBJS_DIR)
			mkdir -p $(OBJS_SUB)

clean:
	rm -rf $(OBJS_BUILD)
	rm -rf $(OBJS_SUB)
	rm -rf $(OBJS_DIR)

fclean: clean
		rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re

# -include $(addprefix $(OBJ_DIR), $(OBJS_BUILD:.o=.d))
-include $(DEPS)
