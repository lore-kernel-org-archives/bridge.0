Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=86k3QMcaxzgeZ7W7KT/L8p/HNMu4qgvr2mrXHZQt+48=;
 b=XZF6052yV10SROVJ2G+TRb4EyzpFdU64n81Pg9f+pT0Wp4Z8alnBfG/0D4NN3CLjA/
 LBOPtyQEiZ21nnyedyROjR5GfSO0BvetrmBhu0P0e/7RWQ5kAzW7QScxxfUuqB5LLQqX
 uEiUmnx8nBcHCG0xVhv3GXy/fjZU82F5aT+l8=
References: <85b1e301-8189-540b-b4bf-d0902e74becc@profihost.ag>
 <20200430105551.GA4068275@splinter>
 <4b3a6079-d8d4-24c5-8fc9-15bcb96bca80@cumulusnetworks.com>
 <20200430155645.GA4076599@splinter>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <ed87d845-035c-37da-5439-1bcfb22fa4c5@cumulusnetworks.com>
Date: Thu, 30 Apr 2020 18:57:55 +0300
MIME-Version: 1.0
In-Reply-To: <20200430155645.GA4076599@splinter>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] BUG: soft lockup while deleting tap interface from
 vlan aware bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, davem@davemloft.net, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>

On 30/04/2020 18:56, Ido Schimmel wrote:
> On Thu, Apr 30, 2020 at 02:20:23PM +0300, Nikolay Aleksandrov wrote:
>> Maybe we can batch the deletes at say 32 at a time?
> 
> Hi Nik,
> 
> Thanks for looking into this!
> 
> I don't really feel comfortable hard coding an arbitrary number of
> entries before calling cond_resched(). I didn't see a noticeable
> difference in execution time with the previous patch versus an unpatched
> kernel. Also, in the examples I saw in the networking code
> cond_resched() is always called after each loop iteration.
> 
> Let me know how you prefer it and I will send a patch.
> 

that's ok, send it as it is

