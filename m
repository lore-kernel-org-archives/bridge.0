Return-Path: <akpm@linux-foundation.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592441031;
 bh=z8URL52jsUeVV4acHgb8mhAwfXotlh0gswF4QwIowhc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lFr7x6WrpgmRN4lzyjuvDZG/zGaopYG62aB1wPAszZtJjQPV9FdWelscdkKZ1qRgQ
 AvtBQETgA+y3uFWv09ZMZ8o39Xuvl5i+wHRZRgNpcmzkR8W9OqNit+yo8ORkU4fGBb
 M3YbM5M6BVVRc9kul9eNloay4TPH74oCLloXGYj4=
Date: Wed, 17 Jun 2020 17:43:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Message-Id: <20200617174348.70710c3ecb14005fb1b9ec39@linux-foundation.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 0/5] kmod/umh: a few fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, bridge@lists.linux-foundation.org, jmorris@namei.org, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, bfields@fieldses.org, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, philipp.reisner@linbit.com, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net

On Wed, 10 Jun 2020 15:49:18 +0000 "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> Tiezhu Yang had sent out a patch set with a slew of kmod selftest
> fixes, and one patch which modified kmod to return 254 when a module
> was not found. This opened up pandora's box about why that was being
> used for and low and behold its because when UMH_WAIT_PROC is used
> we call a kernel_wait4() call but have never unwrapped the error code.
> The commit log for that fix details the rationale for the approach
> taken. I'd appreciate some review on that, in particular nfs folks
> as it seems a case was never really hit before.
> 
> This goes boot tested, selftested with kmod, and 0-day gives its
> build blessings.

Any thoughts on which kernel version(s) need some/all of these fixes?

>  drivers/block/drbd/drbd_nl.c         | 20 +++++------
>  fs/nfsd/nfs4recover.c                |  2 +-
>  include/linux/sched/task.h           | 13 ++++++++
>  kernel/kmod.c                        |  5 ++-
>  kernel/umh.c                         |  4 +--
>  lib/test_kmod.c                      |  2 +-
>  net/bridge/br_stp_if.c               | 10 ++----
>  security/keys/request_key.c          |  2 +-
>  tools/testing/selftests/kmod/kmod.sh | 50 +++++++++++++++++++++++-----

I'm not really sure who takes kmod changes - I'll grab these unless
someone shouts at me.

