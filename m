Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <1432301557-6928-1-git-send-email-linus.luessing@c0d3.blue>
References: <1432301557-6928-1-git-send-email-linus.luessing@c0d3.blue>
Date: Fri, 22 May 2015 09:26:40 -0700
Message-ID: <CAHA+R7MGcfUVPzjt582FkZ1zBx35U71kRRfTFkjHbPiXi=TGTA@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCHv2 net-next] bridge: allow setting hash_max +
 multicast_router if interface is down
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev <netdev@vger.kernel.org>, roopa <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wilson Kok <wkok@cumulusnetworks.com>, "David S. Miller" <davem@davemloft.net>

On Fri, May 22, 2015 at 6:32 AM, Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue> wrote:
> Changelog v2:
> * remove another now unnecessary -ENOENT initialization
> * consistently initialize to -EINVAL, allowing to shorten two switch-case=
s
>

Looks perfect now. :)

Thanks for update.
