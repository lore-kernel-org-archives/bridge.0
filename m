Return-Path: <andriy.shevchenko@linux.intel.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641311039; x=1672847039;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=22y9EjrBRaMVy/mz9REdCI0A1LxLuq5BPOq8HpG1+gg=;
 b=Lwt1OJwTVHlWoTIDAsW9l7wZH57tSzFsO9SRi2qidRjoB0t0bahmNRa2
 srCzWBSKVJ69dcWGOgkrjNE7e3wSStn9tdrrhKz0dWi8ZGJ/qx1Iq0RLY
 2i8XkAxEN+FXSQTnrYHcRSeG9wt41f6nHVXcYb9HMgYLvfXsjkr1fkvIz
 JtUtPefxH28iKq+iFg0NfI0mOG+6k4zYEGfFY3sto2EZVBUL5F4wiJA79
 ZUk96ff1uy6+hJLeA61TdpRZebavZEYBJaKTJEbqY4p2IzJ3luOAGf6Uc
 TMOxyPqBGBE0uTsofhAxTtzW3876f2I5tPX8l4Nk+SxiOdQ+bBSotootu g==;
Date: Tue, 4 Jan 2022 17:42:34 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <YdRq6vKceOqscaKK@smile.fi.intel.com>
References: <20211229004913.513372-1-kuba@kernel.org>
 <5a82690c-7dc0-81de-4dd6-06e26e4b9b92@gmail.com>
 <20211229092012.635e9f2b@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229092012.635e9f2b@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Subject: Re: [Bridge] [PATCH bpf-next v2] net: don't include filter.h from
	net/sock.h
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, mingo@kernel.org
Cc: linux-s390@vger.kernel.org, linux-nfs@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, netfilter-devel@vger.kernel.org, daniel@iogearbox.net, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, ast@kernel.org, linux-can@vger.kernel.org, linux-bluetooth@vger.kernel.org, coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux-foundation.org, ath11k@lists.infradead.org, linux-decnet-user@lists.sourceforge.net

On Wed, Dec 29, 2021 at 09:20:12AM -0800, Jakub Kicinski wrote:
> On Tue, 28 Dec 2021 17:33:39 -0800 Florian Fainelli wrote:
> > It would be nice if we used the number of files rebuilt because of a 
> > header file change as another metric that the kernel is evaluated with 
> > from release to release (or even on a commit by commit basis). Food for 
> > thought.
> 
> Maybe Andy has some thoughts, he has been working on dropping
> unnecessary includes of kernel.h, it seems.

With this [1] announcement I believe Ingo is the best to tell you if this is a
right direction.

> It'd be cool to plug something that'd warn us about significant
> increases in dependencies into the patchwork build bot.
> 
> I have one more small series which un-includes uapi/bpf.h from
> netdevice.h at which point I hope we'll be largely in the clear 
> from build bot performance perspective.

[1]: https://lore.kernel.org/lkml/YdIfz+LMewetSaEB@gmail.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


