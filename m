Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <51506DFE.4040405@cogentembedded.com>
Date: Mon, 25 Mar 2013 19:32:14 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
	<1364131607-11698-1-git-send-email-honkiko@gmail.com>
	<514F0F07.9050702@cogentembedded.com>
	<20130324.171537.1255124338630598287.davem@davemloft.net>
In-Reply-To: <20130324.171537.1255124338630598287.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, zhiguo.hong@emc.com, honkiko@gmail.com, stephen@networkplumber.org, herbert@gondor.hengli.com.au

Hello.

On 25-03-2013 1:15, David Miller wrote:

>>> When neither IFF_BRIDGE nor IFF_BRIDGE_PORT is set,
>>> and afspec == NULL but  protinfo != NULL, we run into
>>> "if (err == 0) br_ifinfo_notify(RTM_NEWLINK, p);" with
>>> random value in ret.

>>> Thanks to Sergei for pointing out the error in commit comments.

>>> Signed-off-by: Hong Zhiguo <honkiko@gmail.com>

>>      For the future, if you post the revised version of the patch, you
>> should indicate in the subject it like this: [PATCH v2].

> I'm disappointed that you have enough energy to point out such a lower
> priority omission, but you lack the time for something more important,
> which is giving this patch your explicit ACK if it fixes all of the
> issues you pointed out to him.

    Sorry, I don't usuallly ACK patches in an area I'm not closely familiar 
with. Though I can add:

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei

