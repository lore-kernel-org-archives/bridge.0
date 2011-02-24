Message-ID: <4D65E2B4.1010501@zytor.com>
Date: Wed, 23 Feb 2011 20:46:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <1297811961-19249-1-git-send-email-linus.luessing@web.de>
	<4D65CD81.4070203@zytor.com>
	<20110224040412.GA25488@gondor.apana.org.au>
In-Reply-To: <20110224040412.GA25488@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Multicast snooping fixes and suggestions
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Herbert Xu <herbert@gondor.hengli.com.au>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@web.de>, "David S. Miller" <davem@davemloft.net>

On 02/23/2011 08:04 PM, Herbert Xu wrote:
> On Wed, Feb 23, 2011 at 07:16:17PM -0800, H. Peter Anvin wrote:
>>
>> Are these packets likely to address that situation (or am I just plain
>> doing something stupid)?
> 
> No these patches deal with IPv6 multicast support in the bridge and
> are not related to your problem.
> 
> If you're using the bridge for virtualisation and you know that
> you don't have a loop in your setup, then one option would be to
> disable STP on your bridge.

Hi,

I have disabled STP on the bridge; it doesn't change the behavior.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

