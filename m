Message-ID: <4BA1ED1D.80806@philkarn.net>
Date: Thu, 18 Mar 2010 02:06:37 -0700
From: Phil Karn <karn@philkarn.net>
MIME-Version: 1.0
References: <20100119214451.72637a94rn0biysz@mx.kpi.ua>	<4B572FCA.8080905@kpi.ua>
	<20100120095453.09546783@nehalam>
	<8cad0aa1001201014ga54cf4br7b77577e874b4472@mail.gmail.com>
In-Reply-To: <8cad0aa1001201014ga54cf4br7b77577e874b4472@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Re :Re: Re :Re: Re :Re: Bridging LACP (802.3ad) frames
 not working
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On 1/20/2010 10:14 AM, Jean-Michel Hautbois wrote:

> I agree, and once again, I wish we could add a flag that enables
> forwarding these frames.
> A flag that would be off by default.
> I don't understand why this could be problematic...

I can think of an admittedly arcane case where forwarding this type of
traffic might get someone in trouble. But it's the arcane cases that can
have you pulling your hair out.

A few months ago I began to experiment with bridging on my Linux system
at work. Although it was impossible for what I was doing to create a
bridging loop, I decided to play it safe and enable STP anyway.

A minute or so later I realized that my network connection was down -
the link light was actually off on the port connected to the cable
coming out of the wall.

To make a long story short, I'd stumbled into a mechanism that the IT
guys at work had implemented, for better or worse, to keep people from
running "unauthorized" bridges. When their switch saw my BPDU frames,
presumably by their special multicast address, it disabled my port for
something like 10 minutes. Apparently they use some sort of commercially
available product to do this. Since then I've noticed that at least some
managed switches have the built-in capability to turn ports off when
they see traffic that an administrator decides he doesn't like.

I don't know if they also disable a port when it sees one of the other
reserved MAC addresses (besides 01:80:c2:0:0:0), or perhaps one of the
special 16-bit types reserved for the slow control protocols. But if
lots of bridges start forwarding management frames that normally aren't
forwarded, then someone who trips a booby trap like the one I did might
end up disabling a much larger chunk of a network than a single port.
And it might take a long time to figure out why.


