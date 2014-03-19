Return-Path: <ratheesh.ksz@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=8hgHkzUEP2TWKO2oMmkfOQYXwbEuGMNd6O77QJw7noU=;
	b=I2bmB77kIWp8tmqIRhHN/UT+KenNiSfVulcaJjXD4LCoVBj3puYSPLSK4CqSXmrxCz
	HqejvPRplyvuz0enX9GKV6mlSPNMJFI8Z5HbxYBXfC9NOMqPSsbJxV0xvURnp785OFhx
	BE3AB8Wer5T5A7LK4xU73CA0G9s5eT8tz9Fh7ymNrVuqX+CSmraaSEYPUCRhxW13cfvE
	N+x5n6GQLQSsZHhmyT4ge0Oo8MugfoRkhCaaevu8Sc9S9vZHatctwvxxmF5UDfhDXYKM
	6HzqfM59GGmFIpySUS9HCOjeajHwMBl9jDhWm5OcAVSDhOzI+CxiXHnLxSkAFqDtqCPA
	JeBA==
MIME-Version: 1.0
In-Reply-To: <CAGZFCEEbccO36dib87TXjVyVudmYhP_Ukgc-MgYOij=adZ=_Tw@mail.gmail.com>
References: <CAGZFCEEbccO36dib87TXjVyVudmYhP_Ukgc-MgYOij=adZ=_Tw@mail.gmail.com>
Date: Wed, 19 Mar 2014 22:46:11 +0530
Message-ID: <CAGZFCEFSp_Ge4cQwmeeUJNpKEi05fyHYrNu4fqhWKcDPT+tEAg@mail.gmail.com>
From: ratheesh kannoth <ratheesh.ksz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Bridge] How packet finally reach internal_dev_xmit() routine
	from outside ?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org, discuss@openvswitch.org

I analysed the code. Please correct me if my understanding is wrong

http://kerala-freaks0.blogspot.in/2014/03/openvswitchfunctionflow.html

On Wed, Mar 19, 2014 at 12:18 PM, ratheesh kannoth
<ratheesh.ksz@gmail.com> wrote:
> Hi list,
>
>
> openvswitch internal devices are not real nic. So some routine should
> receive the packet  for this interface. Who is receiving packet for
> this internal device.
> Any clue is really appreciated .
>
>
> -Ratheesh
