%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "test/", "web/"],
        excluded: [
          ~r"/_build/",
          ~r"/deps/",
          ~r"/node_modules/",
          ~r"/lib/mix/",
          ~r"/test/support"
        ]
      },
      requires: [],
      strict: true,
      color: true,
      checks: [
        {Credo.Check.Readability.ModuleDoc, false}
      ]
    }
  ]
}
