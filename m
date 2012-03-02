Return-Path: <jeewan.girewal@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:content-type; bh=wlDgvvIcabgT1S3/7eyXVWekOoo8rxNMXp6IKuJxYvs=;
	b=pr0O0TKEBQdDtaSKHBXfLR581oI8ZWcHoEBzWgoWyaw0QjrSbWO/M6L+Jxzkvk7b+M
	TbEp8D4WcTVZYU5bc8Lws7KQKrfzKtPIqpHnrt81ohmXKfUM5EyqfAOK/gYOkub5Ya78
	6NvHBm2Ce5mCg4IZ+pg6Sulxt06eWye8CrYMs71RgJYmOfrbu2HDus86aZxEd1NFihZH
	HyZdbpsIBGlL3/XhhQU3rTeU2vosD5i+PLi/ZMQP95uZ2lKgPJj0eMSc6xCpgalbgnvK
	rAIOPgGma8jis8/ALOpKlPoUiPxaoqqI6MagsTEMKvu0SXELMCwoOkasp0YrNccyEnDH
	XjiQ==
MIME-Version: 1.0
In-Reply-To: <CAPpZ4vfHMzez8RLPabN3Dzu4t1dkaDPncS8kwZ15q_KattCL0A@mail.gmail.com>
References: <CAPpZ4vfHMzez8RLPabN3Dzu4t1dkaDPncS8kwZ15q_KattCL0A@mail.gmail.com>
Date: Fri, 2 Mar 2012 23:44:14 +0200
Message-ID: <CAPpZ4vca4YntvCEgddJE7+0y9ePSKzqVFyuRJq3fmi8u2bMM3Q@mail.gmail.com>
From: jeewan girewal <jeewan.girewal@gmail.com>
Content-Type: multipart/alternative; boundary=14dae934116557747304ba497ae2
Subject: [Bridge] Want to add IP options into IP header,
	unable to resolve symbol
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com

--14dae934116557747304ba497ae2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I want to use the function defined in in net/ip_options.c file like
ip_options_compile, ip_options_build in my netfilter module. I want to put
options into IP packet header. I have inserted the header file that
declares these function. I have used EXPORT_SYMBOL, but I get warning,
"ip_options_compile" undefined. Any suggestions will be greatly respected.
I am using Ubuntu 11.10. uname -a: 3.0.0-16-generic. Is there a way to make
this symbol visible for newer kernel?

-Jeewan

--14dae934116557747304ba497ae2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">Hi,<br><br>I want to use the function define=
d in in net/ip_options.c file like ip_options_compile, ip_options_build in =
my netfilter module. I want to put options into IP packet header. I have in=
serted the header file that declares these function. I have used EXPORT_SYM=
BOL, but I get warning, &quot;ip_options_compile&quot; undefined. Any sugge=
stions will be greatly respected. I am using Ubuntu 11.10. uname -a: 3.0.0-=
16-generic. Is there a way to make this symbol visible for newer kernel?<sp=
an class=3D"HOEnZb"><font color=3D"#888888"><br>

<br>-Jeewan<br>
</font></span></div><br>

--14dae934116557747304ba497ae2--
