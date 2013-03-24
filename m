Return-Path: <davem@davemloft.net>
Date: Sun, 24 Mar 2013 17:15:37 -0400 (EDT)
Message-Id: <20130324.171537.1255124338630598287.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <514F0F07.9050702@cogentembedded.com>
References: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
	<1364131607-11698-1-git-send-email-honkiko@gmail.com>
	<514F0F07.9050702@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: avoid br_ifinfo_notify when
 nothing changed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, zhiguo.hong@emc.com, honkiko@gmail.com, stephen@networkplumber.org, herbert@gondor.hengli.com.au

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 24 Mar 2013 17:34:47 +0300

> Hello.
> 
> On 03/24/2013 04:26 PM, Hong Zhiguo wrote:
> 
>> When neither IFF_BRIDGE nor IFF_BRIDGE_PORT is set,
>> and afspec == NULL but  protinfo != NULL, we run into
>> "if (err == 0) br_ifinfo_notify(RTM_NEWLINK, p);" with
>> random value in ret.
>>
>> Thanks to Sergei for pointing out the error in commit comments.
>>
>> Signed-off-by: Hong Zhiguo <honkiko@gmail.com>
> 
>     For the future, if you post the revised version of the patch, you
> should indicate in the subject it like this: [PATCH v2].

I'm disappointed that you have enough energy to point out such a lower
priority omission, but you lack the time for something more important,
which is giving this patch your explicit ACK if it fixes all of the
issues you pointed out to him.
