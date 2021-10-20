Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hi2XgGMyKlW1UQqVPtudcWKRJ8oy8AP52PmaKHN5Psc=;
 b=TtnXz8j05nBGuK9AZ6rd7YHuSUTGgXo+fTuhC5awTXnhYCoD9ZQUU50R+q/yV24wAF
 TqQP8T+SAV6UEwVqPVpU0mPWV9pfdjcuT6ad0aQPiDYtzzOxTlnHNsbTBSagcH+TZdVR
 NgnNW7PfsUp8d7xgHqLvA0+JcKaiwF+9dByN0lLIuHIgyvGk//P4mCp+Reg5GpuBJ6P/
 HY2/R3ve6aaMjGCi43VJxxcoiQ2hOT77jMQxVuRikI2INC8/Q9F1pnYpTaU28QDATKhb
 ZyU0lgUqMPWn/Af/0N8K6CcUs0izUXaBTEv+hsuxVxB0YzdnNU2U7WqTjNmDA0eyWAYT
 LODg==
Date: Wed, 20 Oct 2021 09:02:01 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <YW9qiUhDKT+56wkd@Laptop-X1>
References: <20211018082612.625417-1-liuhangbin@gmail.com>
 <ab707f4d-587a-0fae-e673-5da49f5946db@nvidia.com>
 <YW5a9JLnfZc1M8Gh@Laptop-X1>
 <a6bbd579-3d5f-6cbd-9523-49226a2b5a7a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6bbd579-3d5f-6cbd-9523-49226a2b5a7a@nvidia.com>
Subject: Re: [Bridge] [PATCH net] net: bridge: mcast: Do not allow users to
 set IGMP counter/timer to zero
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: kuba@kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On Tue, Oct 19, 2021 at 07:09:42PM +0300, Nikolay Aleksandrov wrote:
> > I started this patch when I saw there is not limit for setting
> > multicast_membership_interval to 0, which will cause bridge remove the
> > mdb directly after adding. Do you think this is a problem.
> > 
> > And what about others? I don't think there is a meaning to set other intervals
> > to 0.
> > 
> 
> The problem is not if there is meaning, we cannot start restricting option values now after
> they've become uapi (and have been for a very long time) because we can break user-space even
> though chances are pretty low. I don't think this patch is acceptable, I commented on the other
> patch issues but they don't matter because of this.

OK, I got your mean, we should not restrict the configurations based on whether
there is a meaning.

Thanks
Hangbin
