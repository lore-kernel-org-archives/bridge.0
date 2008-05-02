Date: Fri, 2 May 2008 14:32:39 -0400
From: "John W. Linville" <linville@tuxdriver.com>
Message-ID: <20080502183239.GC13183@tuxdriver.com>
References: <481597F3.6060400@sneakemail.com>
	<20080428125307.GB3499@tuxdriver.com> <481B034B.70606@no-spam.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <481B034B.70606@no-spam.net>
Subject: Re: [Bridge] Ethernet+Wireless Bridge?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nicolas <nicolas@no-spam.net>
Cc: bridge@lists.linux-foundation.org

On Fri, May 02, 2008 at 02:04:27PM +0200, Nicolas wrote:
> John W. Linville a =E9crit :
> >=20
> > Spoofing the source MAC is actually forbidden by the 802.11 standard.

> But wouldn't it be possible, as a temporary and dirty fix, to simply=20
> send any outgoing frames with the wireless interface MAC as the source=20
> MAC when the bridge send on a wireless interface ?

Having given this almost no thought, I suppose it might be possible to
make it 'work' (for some definition of 'work'), in combination with
routing and proxy ARP.  Of course if you are going to route anyway,
it is hard to see why you would need to bridge.

John
--=20
John W. Linville
linville@tuxdriver.com
