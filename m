Return-Path: <christophe.jaillet@wanadoo.fr>
References: <00c39d09c8df7ad0673bf2043f6566d6ef08b789.1636916479.git.christophe.jaillet@wanadoo.fr>
 <20211115123534.GD26989@kadam>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <b3c93506-7dc8-a5fe-6cfc-938fc88b9f07@wanadoo.fr>
Date: Mon, 15 Nov 2021 19:35:48 +0100
MIME-Version: 1.0
In-Reply-To: <20211115123534.GD26989@kadam>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] net: bridge: Slightly optimize 'find_portno()'
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

Le 15/11/2021 à 13:35, Dan Carpenter a écrit :
> On Sun, Nov 14, 2021 at 08:02:35PM +0100, Christophe JAILLET wrote:
>> The 'inuse' bitmap is local to this function. So we can use the
>> non-atomic '__set_bit()' to save a few cycles.
>>
>> While at it, also remove some useless {}.
> 
> I like the {} and tend to add it in new code.  There isn't a rule about
> this one way or the other.
> 
> regards,
> dan carpenter
> 
> 
> 

Hi Dan,

- checkpatch prefers the style without {}
- Usually, greg k-h and Joe Perches give feed-back that extra {} should 
be removed.
- in https://www.kernel.org/doc/html/v5.13/process/coding-style.html, 
after "Rationale: K&R":
    "Do not unnecessarily use braces where a single statement will do."


My own preference is to have {}. It is the standard used on another 
project I work on (i.e. httpd) and it helps when you add some code (it 
avoids unexpected behavior if you forget to add some missing {})

My understanding is that on the HUGE code base of Linux, emphasis is put 
on saving some lines of code, reducing the length of lines and avoiding 
the need to read some extra char.
I'm also fine with it.

CJ
