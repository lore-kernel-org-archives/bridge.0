Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=91mr6eeADorjnfR5x6lK4E8CAqAHq5gQKNZL6IXrUFA=;
 b=bQA61WiJYd7BqY39Yve6U2jh2wYlAPueDf+k46tLEX1y3Aj89Yno4yd9FjOOUMU8eE
 qaBZqveZUZGDG0MltiNRwN5Fdz/2fNYsoZlgrNyJe3P0+AdoFtwpeyQCrx/DhcQPy3b/
 zRLUGxmcOGbmoSBmX/KC7RuG3f9wNB+fPaTQM=
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
 <20191210143931.GF1344570@t480s.localdomain>
 <2f4e351c-158a-4f00-629f-237a63742f66@cumulusnetworks.com>
 <20191210151047.GB1423505@t480s.localdomain>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <1aa8b6e4-6a73-60b0-c5fb-c0dfa05e27e6@cumulusnetworks.com>
Date: Tue, 10 Dec 2019 22:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <20191210151047.GB1423505@t480s.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On 10/12/2019 22:10, Vivien Didelot wrote:
> Hi Nikolay,
> 
> On Tue, 10 Dec 2019 21:50:10 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>>>> Why do you need percpu ? All of these seem to be incremented with the
>>>> bridge lock held. A few more comments below.
>>>
>>> All other xstats are incremented percpu, I simply followed the pattern.
>>>
>>
>> We have already a lock, we can use it and avoid the whole per-cpu memory handling.
>> It seems to be acquired in all cases where these counters need to be changed.
> 
> Since the other xstats counters are currently implemented this way, I prefer
> to keep the code as is, until we eventually change them all if percpu is in
> fact not needed anymore.
> 
> The new series is ready and I can submit it now if there's no objection.
> 
> 
> Thanks,
> 
> 	Vivien
> 

There is a reason other counters use per-cpu - they're incremented without any locking from fast-path.
The bridge STP code already has a lock which is acquired in all of these paths and we don't need
this overhead and the per-cpu memory allocations. Unless you can find a STP codepath which actually
needs per-cpu, I'd prefer you drop it.

Thank you,
 Nik
