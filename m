Date: Mon, 7 Nov 2005 13:18:36 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Backport
Message-ID: <20051107131836.3ce41eb0@dxpl.pdx.osdl.net>
In-Reply-To: <30be90270511071302vbcad09fl148b5e742ae489b9@mail.gmail.com>
References: <30be90270511071302vbcad09fl148b5e742ae489b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <u2.ireland@gmail.com>
Cc: bridge@lists.osdl.org

On Mon, 7 Nov 2005 16:02:41 -0500
Hai Wang <u2.ireland@gmail.com> wrote:

> Hell everyone,
>   I am wondering if any of you had backported bridge driver to kernel 2.4.x?
>  Thanks!
>  Hai

There already is a bridge driver in 2.4 but it is older.
The 2.6 code relies on RCU, which is not in 2.4.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
