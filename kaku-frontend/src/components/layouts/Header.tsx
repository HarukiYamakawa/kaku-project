import Link from "next/link";
const Header = () => {
    return (
      <header className="fixed top-0 w-full text-white z-10">
      <div className="bg-[#8dc63f] p-4">
      <Link href="/">
        <h1 className="text-xl">Kaku</h1>
      </Link>
      </div>
      <nav className="bg-[#6da332] p-4 ">
        <ul className="flex space-x-2">

            <Link href="/product/list">
              <h2>商品一覧</h2>
            </Link>
            <Link href="/product/registration">
              <h2>商品登録</h2>
            </Link>

        </ul>
      </nav>
    </header>
  );
}
export default Header