{ ... }:
{
    programs.git = {
        enable = true;

        config = {
            user = {
                name = "Maksim";
                email = "karnalize@mail.ru";
            };

            init.defaultBranch = "main";
        };
    };

}