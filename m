References: <87skv27wiv.fsf@q-software-solutions.de>
	<20080624093133.6f2b896b@extreme>
	<87fxr16h9j.fsf@q-software-solutions.de>
	<20080625110633.2c6c6c76@extreme>
From: Friedrich Dominicus <frido@q-software-solutions.de>
Date: Thu, 26 Jun 2008 06:47:53 +0200
In-Reply-To: <20080625110633.2c6c6c76@extreme> (Stephen Hemminger's message of
	"Wed, 25 Jun 2008 11:06:33 -0700")
Message-ID: <871w2kls3q.fsf@q-software-solutions.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Bridge] Bridge troubles
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: bridge@lists.linux-foundation.org

Stephen Hemminger <shemminger@vyatta.com> writes:

>> 
>> 
>> 
>
> Or different hardware on the two machines?
Well they all use them 8139 somewhat driver for network cards. 

So I tried my luck with a Intel Dual Core 64-bit running kernel:
2.6.22 and on AMD Dual Core 64-bit running 2.6.24. Both show the same
problems. And then I tried my luck on some 32-bit linux which I
updated yesterday to run kernel 2.6.25, and there bridiging works as I
expected but on the 64-bit machines I got this strange messages. 

Regards
Friedrich
