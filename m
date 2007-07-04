DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
	b=T5Pyh2+MNa1iVrhXufy+HQkpQjbAgoITh42j9VkuZ+9HpyU38cqbpmYSUFfJTJwaElmS3dZH+GABCzmihelfqVGfNpEUKfZ3gnPQ4PbLjC5AeMMcGSNF1UZu2EoRyUyALdSD2+gRtIxRCSDRvDYIixdgCVwk9g5Dir6ej9LMBKY=
Message-ID: <ca5165530707041013t5244a689i48af633a3fb1d9d7@mail.gmail.com>
Date: Wed, 4 Jul 2007 10:13:46 -0700
From: "Larry Brigman" <larry.brigman@gmail.com>
Subject: Re: [Bridge] want to cross_compile bridge-utils
In-Reply-To: <fbcae4d0707030344t7e12488ey7724b86c0f2f27f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fbcae4d0707030344t7e12488ey7724b86c0f2f27f4@mail.gmail.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Priyanka Gupta <p.priyankagupta@gmail.com>
Cc: bridge@osdl.org

On 7/3/07, Priyanka Gupta <p.priyankagupta@gmail.com> wrote:
> Hi,
>
> I have downloaded bridge-utils-1.2.tar.gz. I want to crosscompile it for
> customized linux2.6 version for am platform. How can I do it?
>

Just set the variables listed at the end of ./configure --help to your
cross-compiler.
You will also have to edit the Resulting Makefile for ar and randlib
in libbridge as
these are not handled in the configure script correctly.

With these steps I have the package compiling for mips64, arm and cross-x86.
