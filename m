Message-ID: <20050823072540.15385.qmail@web34109.mail.mud.yahoo.com>
Date: Tue, 23 Aug 2005 00:25:40 -0700 (PDT)
From: Zoran s <s_zoran@yahoo.com>
Subject: Re: [Bridge] ppp0 to eth0
In-Reply-To: <20050809143639.423bf696@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>, Eduardo Osorio <eduardo.osorio.armenta@gmail.com>
Cc: bridge@lists.osdl.org

There is an interesting article covering bridging, but
I think the interfaces are considered to type of
ethernet, no ppp ever considered!

http://www.linuxjournal.com/article/8172

The problem with ppp is that for the dial-up, as I
understand, ppp is NOT over eth (PPPoE), but rather
over some specific Data Link Layer described in V.90
standards.

As I also understand, the web portal for dial-up is on
the linux machine, where the whole process of PAP/CHAP
and autentification with ISP takes place. The ISP
assigns dynamic IP address to dial-up interface, so
NAT is required to maintain xla to private subnet
residing on the ethernet interface.

Then, every node of private subnet will automatically
have access to the internet.

Routing is the magic word. :)

--- Stephen Hemminger <shemminger@osdl.org> wrote:

> On Tue, 9 Aug 2005 13:51:40 -0500
> Eduardo Osorio <eduardo.osorio.armenta@gmail.com>
> wrote:
> 
> > Hi,
> > 
> > i wonder if there's some howto information to 
> > bridge ppp0 to eth0
> > 
> > my distribution is a Hoary Ubuntu 5.04
> > 
> > i install :    apt-get install bridge-utlis
> > 
> > what i need it's connect to internet thru a modem
> 56k (ppp0)
> > and then give internet access to my laptop thru a
> crosspair cable
> > attached to a eth0 in my linux box .
> > 
> > i was following the article
> > http://www.linuxjournal.com/article/8261
> > 
> > does anyone knows where i can find that
> information
> > 
> > the FAQ of bridge http://bridge.sourceforge.net/
> > mencion that ppp it's posible.
> > 
> > thanks in advance for clarification, commets etc
> > 
> 
> You will have better luck using routing and NAT to
> do this.
> Otherwise, your ISP will have to allow multiple IP's
> over a single
> PPP connection.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
