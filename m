Return-Path: <ap420073@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dqh4dH8aZ6HN+B6a/NbTwQiRYC2u5Akv4+7vt6N7BqI=;
 b=XY9Yv9AWPcZwWKle2oLxy6MXxZYJ/wI3gWfHvn1lwE0JJXaahPaKvpQZfVqimJVczU
 6cKT0NyHZMxVxRYb1j2gl3iw6Tk0aJJSghG2us6p4q5uzGj/Bi7mgOvUX+hqf3MhzQg+
 gTBcuWVt1SUt7oWg50ZtZ1OR0L2iUpJEBqTZ12/nkPhOna7owJ3beyuLuIs3y6kI1/0z
 +V/a4ZdA7XHpDRqjZ4u5iYt6ECEjJ3wudJb3xa4WXtVz2JMzaaRgGQ4XBw4aHI86j7pH
 D+LyTlb4q5HRHj7KWC+tPmNrO2NaYpKzJ1YP7lWKjUMaesuaq1PzEn1tPnB5qQMKro/f
 FqHA==
References: <20210425155742.30057-1-ap420073@gmail.com>
 <20210425155742.30057-3-ap420073@gmail.com>
 <ed54816f-2591-d8a7-61d8-63b7f49852c1@nvidia.com>
 <20210426124806.4zqhtn4wewair4ua@gondor.apana.org.au>
 <1e8cda49-4bc3-6f0b-29f3-97848aab18f0@nvidia.com>
From: Taehee Yoo <ap420073@gmail.com>
Message-ID: <68b18d15-d472-3305-4f91-5e61f8b60488@gmail.com>
Date: Tue, 27 Apr 2021 00:17:52 +0900
MIME-Version: 1.0
In-Reply-To: <1e8cda49-4bc3-6f0b-29f3-97848aab18f0@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 2/2] net: bridge: fix lockdep
 multicast_lock false positive splat
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: bridge@lists.linux-foundation.org, cong.wang@bytedance.com, daniel@iogearbox.net, yoshfuji@linux-ipv6.org, j.vosburgh@gmail.com, dsahern@kernel.org, roopa@nvidia.com, ast@kernel.org, bjorn@kernel.org, vfalico@gmail.com, netdev@vger.kernel.org, kuba@kernel.org, weiwan@google.com, andriin@fb.com, davem@davemloft.net

On 4/26/21 10:15 PM, Nikolay Aleksandrov wrote:
 > On 26/04/2021 15:48, Herbert Xu wrote:

Hi Nikolay and Herbert,
Thank you for the reviews!

 >> On Sun, Apr 25, 2021 at 07:45:27PM +0300, Nikolay Aleksandrov wrote:
 >>>
 >>> Ugh.. that's just very ugly. :) The setup you've described above is 
by all means invalid, but
 >>> possible unfortunately. The bridge already checks if it's being 
added as a port to another
 >>> bridge, but not through multiple levels of indirection. These locks 
are completely unrelated
 >>> as they're in very different contexts (different devices).
 >>
 >> Surely we should forbid this? Otherwise what's to stop someone
 >> from creating a loop?
 >>
 >> Cheers,
 >>
 >
 > Indeed that would be best, it's very easy to loop them.
 >

We can make very various interface graphs with master/slave interface types.
So, if we need something to forbid it, I think it should be generic 
code, not only for the bridge module.
