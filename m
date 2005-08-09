Date: Tue, 9 Aug 2005 14:36:39 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] ppp0 to eth0
Message-ID: <20050809143639.423bf696@dxpl.pdx.osdl.net>
In-Reply-To: <933ef85e05080911512c36b226@mail.gmail.com>
References: <933ef85e05080911512c36b226@mail.gmail.com>
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
To: Eduardo Osorio <eduardo.osorio.armenta@gmail.com>
Cc: bridge@lists.osdl.org

On Tue, 9 Aug 2005 13:51:40 -0500
Eduardo Osorio <eduardo.osorio.armenta@gmail.com> wrote:

> Hi,
> 
> i wonder if there's some howto information to 
> bridge ppp0 to eth0
> 
> my distribution is a Hoary Ubuntu 5.04
> 
> i install :    apt-get install bridge-utlis
> 
> what i need it's connect to internet thru a modem 56k (ppp0)
> and then give internet access to my laptop thru a crosspair cable
> attached to a eth0 in my linux box .
> 
> i was following the article
> http://www.linuxjournal.com/article/8261
> 
> does anyone knows where i can find that information
> 
> the FAQ of bridge http://bridge.sourceforge.net/
> mencion that ppp it's posible.
> 
> thanks in advance for clarification, commets etc
> 

You will have better luck using routing and NAT to do this.
Otherwise, your ISP will have to allow multiple IP's over a single
PPP connection.
