OCAMLOPT = ocamlopt

NAME = real_reactions

SOURCES = atom.ml molecule.ml alkane.ml reaction.ml main.ml

OBJS = $(SOURCES:.ml=.cmx)

all: $(NAME)

$(NAME): $(OBJS)
	$(OCAMLOPT) -o $@ $(OBJS)

%.cmx: %.ml
	$(OCAMLOPT) -c $<

clean:
	rm -f *.cmx *.cmi *.o

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re