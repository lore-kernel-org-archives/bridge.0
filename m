Return-Path: <colin.king@canonical.com>
References: <20170815065025.18471-1-colin.king@canonical.com>
	<6b38b83c-21b3-5cec-6145-cdbb54a63dd2@cogentembedded.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <0e49a883-9b39-98e7-7c36-6e433bb3961d@canonical.com>
Date: Tue, 15 Aug 2017 10:51:15 +0100
MIME-Version: 1.0
In-Reply-To: <6b38b83c-21b3-5cec-6145-cdbb54a63dd2@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: fix indent on in statements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, Florian Westphal <fw@strlen.de>, Stephen Hemminger <stephen@networkplumber.org>, "David S . Miller" <davem@davemloft.net>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

On 15/08/17 10:45, Sergei Shtylyov wrote:
> Hello!
> 
> On 8/15/2017 9:50 AM, Colin King wrote:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The returns on some if statements are not indented correctly,
> 
>    s/in/if/ in the subject?

Doh, fix resent.

> 
>> add in the missing tab.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> [...]
> 
> MBR, Sergei
> -- 
> To unsubscribe from this list: send the line "unsubscribe
> kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

