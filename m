Subject: Re: [Bridge] bridge in 'hub' mode possible?
References: <87d5xw4uui.fsf@aka.i.naked.iki.fi>
	<20041129102432.24888dad@zqx3.pdx.osdl.net>
From: Nuutti Kotivuori <naked@iki.fi>
Date: Mon, 29 Nov 2004 20:32:23 +0200
In-Reply-To: <20041129102432.24888dad@zqx3.pdx.osdl.net> (Stephen
	Hemminger's message of "Mon, 29 Nov 2004 10:24:32 -0800")
Message-ID: <87ekic1p6w.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bridge@osdl.org

Stephen Hemminger wrote:
> On Mon, 29 Nov 2004 16:01:57 +0200
> Nuutti Kotivuori <naked@iki.fi> wrote:
>> That is, effectively to just turn off MAC address learning and
>> treat all packets on the bridge level effectively as broadcasts.
>
> Why, are you trying to work around flaws in the underlying Ethernet
> layer. If so, fix it there.

No, I am trying to allow tcpdumping of all traffic travelling through
the bridge at any port of the bridge, most of which are running UML
virtual machines.

This isn't fixing some flaw, or trying to work around features - for
example it is a legitimate need to be able to set up a dumper for some
part of the network. At my former workplace, we used to have a
'guaranteed hub' - an old 10Mbit hub that was guaranteed to do no MAC
address learning - that we used when we needed to dump some traffic
for a certain computer.

And no, the bridge will not be running spanning tree protocol either.

>> Or could this be done with some ebtables hack?
>
> Yes

Instructions appreciated, then.

-- Naked
