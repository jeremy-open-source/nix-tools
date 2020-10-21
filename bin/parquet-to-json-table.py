import argparse
import pandas


def main():
    args = get_args()

    df = pandas.read_parquet(args["input"])
    df.to_json(open(args["output"], mode="w"), orient='table')


def get_args() -> dict:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--input",
        required=True,
        help="Input file location.",
    )
    parser.add_argument(
        "--output",
        required=False,
        default=None,
        help="Output file location.",
    )
    args = parser.parse_args().__dict__
    if args["output"] is None:
        # This could probably be done better!
        args["output"] = args["input"].replace(".parquet", ".json")
    return args


if __name__ == '__main__':
    main()
