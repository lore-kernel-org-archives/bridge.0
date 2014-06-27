Return-Path: <fw@strlen.de>
From: Florian Westphal <fw@strlen.de>
Message-ID: <20140627185207.GA2843@breakpoint.cc>
References: <20140627174837.GG1353@login.tika.stderr.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140627174837.GG1353@login.tika.stderr.nl>
Subject: Re: [Bridge] Unable to DNAT packets back into originating bridge
	port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 27 Jun 2014 18:52:13 -0000
To: Matthijs Kooijman <matthijs@stdin.nl>, Stephen Hemminger <stephen@networkplumber.org>, Bart De Schuymer <bart.de.schuymer@pandora.be>, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

Matthijs Kooijman <matthijs@stdin.nl> wrote:
> I recently stumbled upon an issue in my iptables setup. After some
> extensive debugging, I've found that the problem occurs when trying to
> DNAT (+SNAT) a packet that comes in through a bridge, back into the same bridge
> port it originated from.
> 
> The code ultimately responsible for this is the should_deliver function
> [1], which prevents packets from being delivered back to their
> originating port (ultimately to prevent bouncing broadcast message, I
> believe).

Sounds like
http://marc.info/?t=136627796900001&r=1&w=2
