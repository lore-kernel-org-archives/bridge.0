Return-Path: <aclaudi@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F48C40207
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68BB24010D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694807551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNgfdJeO076tImx6jFh9hOiFdIPM4yz7+TlZmmONbfo=;
 b=caYd3g/OTvPdRkqJGjSUOni9v8dLL1ubt/idcXL2Pgv5sQztmarzgqw9LAmU0ZRAl+T6WF
 Kyw8+9gfA3zlTzVvsxV+2GiEwlrVYWO3PXB2ymx1b4MiCBqdg4Q6ErBA40DHGMFW7B16u1
 fJw0WJ4y0JDmXv3lA2fRRZtau9WZDYM=
Date: Fri, 15 Sep 2023 21:52:22 +0200
From: Andrea Claudi <aclaudi@redhat.com>
Message-ID: <ZQS19lwZlso1AMAR@renaissance-vector>
References: <cover.1694625043.git.aclaudi@redhat.com>
 <844947000ac7744a3b40b10f9cf971fd15572195.1694625043.git.aclaudi@redhat.com>
 <20230915085912.78ffd25c@hermes.local>
MIME-Version: 1.0
In-Reply-To: <20230915085912.78ffd25c@hermes.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Bridge] [PATCH iproute2-next 1/2] configure: add the --color
	option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>

On Fri, Sep 15, 2023 at 08:59:12AM -0700, Stephen Hemminger wrote:
> On Wed, 13 Sep 2023 19:58:25 +0200
> Andrea Claudi <aclaudi@redhat.com> wrote:
> 
> > This commit allows users/packagers to choose a default for the color
> > output feature provided by some iproute2 tools.
> > 
> > The configure script option is documented in the script itself and it is
> > pretty much self-explanatory. The default value is set to "never" to
> > avoid changes to the current ip, tc, and bridge behaviour.
> > 
> > Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
> > ---
> 
> More build time config is not the answer either.
> Don't want complaints from distribution users about the change.
> Needs to be an environment variable or config file.
>

Hi Stephen,
This is not modifying the default behaviour; as David noted color output
will be off as it is right now. If packagers want to make use of this,
it's up to them to choose a sane default for their environment. After
all, we are providing options such as '--prefix' and '--libdir', and
there are endless possibilities to choose obviously wrong values for
these vars. Packagers are gonna deal with their own choices.

I think I can improve this in two ways:

1. Exclude 'always' from the allowed color choices
This is the setting with the highest chance to produce complaints, since
it is enabling color output regardless of stdout state. 'auto' instead
produces color output only on stdout that are terminals. Of course
'always' will remain as a param choice for the command line.

2. Add packaging guidelines to README (or README.packaging)
iproute packaging is a bit tricky, since some packaging systems simply
assume that configure comes from autotools. We even leverage this to our
advantage, providing configure options that packaging systems use
flawlessly as the autotools ones. I can provide some info about this,
and add some recommendations about sane configure defaults, especially
about the --color option.

What do you think? Is this approach fine for you?

