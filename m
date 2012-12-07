Return-Path: <wharms@bfs.de>
Message-ID: <50C2405E.1070904@bfs.de>
Date: Fri, 07 Dec 2012 20:15:42 +0100
From: walter harms <wharms@bfs.de>
MIME-Version: 1.0
References: <20121207111045.GA9676@elgon.mountain> <50C2143C.2010200@bfs.de>
	<20121207185359.GP22569@mwanda>
In-Reply-To: <20121207185359.GP22569@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch v2] bridge: make buffer larger in br_setlink()
Reply-To: wharms@bfs.de
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, Thomas Graf <tgraf@suug.ch>, Stephen Hemminger <shemminger@vyatta.com>, "David S. Miller" <davem@davemloft.net>



Am 07.12.2012 19:53, schrieb Dan Carpenter:
> On Fri, Dec 07, 2012 at 05:07:24PM +0100, walter harms wrote:
>>
>>
>> Am 07.12.2012 12:10, schrieb Dan Carpenter:
>>> We pass IFLA_BRPORT_MAX to nla_parse_nested() so we need
>>> IFLA_BRPORT_MAX + 1 elements.  Also Smatch complains that we read past
>>> the end of the array when in br_set_port_flag() when it's called with
>>> IFLA_BRPORT_FAST_LEAVE.
>>>
>>
>>
>>
>> I have no clue why nla_parse_nested() need IFLA_BRPORT_MAX elements.
>> but the majory of loop look like
>> for(i=0;i<max;++)
>> most programmers will think this way.
>> So it seems the place to fix is nla_parse_nested().
>> doing not so is asking for trouble (in the long run).
>> At least this function needs a big warning label that (max-1)
>> is actually needed.
>>
> 
> Yeah, nla_parse_nested() is actually documented already.
> 


documenting unexspected behavier is not as much helpfull as changing it.

just my 2 cents,
 wh

