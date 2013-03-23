Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <514DC504.5060101@cogentembedded.com>
Date: Sat, 23 Mar 2013 19:06:44 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
In-Reply-To: <1364015653-7322-1-git-send-email-honkiko@gmail.com>
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
To: Hong Zhiguo <honkiko@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, zhiguo.hong@emc.com, stephen@networkplumber.org, herbert@gondor.hengli.com.au, davem@davemloft.net

Hello.

On 23-03-2013 9:14, Hong Zhiguo wrote:

> When neither IFF_BRIDGE_PORT or IFF_BRIDGE_PORT is set,

    That is the same flag repeated twice.

> and afspec == NULL but  protinfo != NULL, we run into
> "if (err == 0) br_ifinfo_notify(RTM_NEWLINK, p);" with
> random value in ret.

> Signed-off-by: Hong Zhiguo <honkiko@gmail.com>

WBR, Sergei

