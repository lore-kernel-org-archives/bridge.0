Date: Fri, 7 Jul 2006 11:46:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060707114611.6a5e988b@dxpl.pdx.osdl.net>
In-Reply-To: <1151417461.14087.10.camel@localhost.localdomain>
References: <1151417461.14087.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge+filter+failover+rules&state sync+traffic shaping
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Tristan DEFERT <tristan.d@alphamosa.fr>
Cc: bridge@lists.osdl.org

On Tue, 27 Jun 2006 16:11:01 +0200
Tristan DEFERT <tristan.d@alphamosa.fr> wrote:

> hi list!
> i'm trying to find a convenient way to build a redundant filtering
> bridge under linux
> 
> i looked at carp project, but carp doesn't support bridge
> 
> now i thing the most appropriate way is using stp or rstp
> it seems that 2.6 kernel supports stp but what about rstp?

The 2.6.18 kernel has hooks to allow building STP protocols in user land.
There is a student working on RSTP as a Google Summer of Code project.
