Return-Path: <federico.vaga@vaga.pv.it>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-type:content-type:content-transfer-encoding:mime-version
	:references:in-reply-to:message-id:date:date:subject:subject
	:from:from:received:received:received; s=dkim20160331; t=
	1560183940; x=1561998341; bh=ySLNIX1jiCqldrmER8p/c1YOLUiUU7vfIBo
	k3u7v1yA=; b=Qbjr2lAFN/nwTVFb3YkUWU/8tkK2xRuhjZsLMgdCND9R34aGoNh
	L2rcHMjFoWIBOEyBgi+MymRMgil8vhsvUkvUoupC7SoATMEh/iy6YPVpjA+5H4ji
	Sq9azbND3/SSpkJHQo81xewDfs7u1H8fnDh9kVM4AjM48YEfBXsuVqT4rapzKmul
	1Ei88sIKitJClBwofZmi6InRA8gbKUKcVg7DR+C8Og1oKRbf3v3PTi2BIL/5Ow+m
	fE5WCn3ir1WHhOXjbX9mYQIY6ionQ0oEGjmBF7gnqu8ILBGEfAUdczCqRfLLNKCu
	Mgna0odiTpKA/ttrTXGmAUMaLJYKwuOFR2wMFJm6jNdjUVsq50EPgBNt5hojESRK
	ARVzFlktwS9I7Dg3zxTTNCvNs1SDiPwRgnX2zRa6o2Hrxw0ZA9SD5NGvxwjwYkXn
	RcfHGYEqdsFjfhrPUKzbyHovzfhc/DvM6es5MEDChVM6hbtU3ebGQuYz5ZzCLoU5
	Tf5CE5ptqRaJnjqoewc+2I8Ou8dWd2AozVQYRI4NAjcWVDkkpXeNqNKSa8KUmZ9G
	AbcsC0D7p3FXd28Z6d8F8A8HeKobEE1AM4rGfzQsMzvMT1TA0Dv5erAQVa/NLGEs
	kZJ5ZtcjwU/5TJ6pEvxuxKdns93Yhvd/oWDj/yITosqRFhYy+AwM5lfQ=
From: Federico Vaga <federico.vaga@vaga.pv.it>
Date: Mon, 10 Jun 2019 18:25:36 +0200
Message-ID: <6349042.qd6NX4z2Zd@harkonnen>
In-Reply-To: <3d40d111d0512d785b6a67573772f532f88d2359.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
	<3d40d111d0512d785b6a67573772f532f88d2359.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Bridge] [PATCH v3 14/33] docs: kbuild: convert docs to ReST
	and rename to *.rst
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: , linux-wireless@vger.kernel.org, linux-fbdev@vger.kernel.org, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Stanislaw Gruszka <sgruszka@redhat.com>, Vignesh Raghavendra <vigneshr@ti.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, bridge@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infr>, Palmer Dabbelt <palmer@sifive.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Ofer Levi <oferle@mellanox.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Harry Wei <harryxiyou@gmail.com>, Paul Mackerras <paulus@samba.org>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Jonas Bonn <jonas@southpole.se>, Alex Shi <alex.shi@linux.alibaba.com>, linux-c6x-dev@linux-c6x.org, linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, netdev@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, coreteam@netfilter.org, Mark Salter <msalter@redhat.com>, Al exey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-snps-arc@lists.infradead.org, Roopa Prabhu <roopa@cumulusnetworks.com>, Pablo Neira Ayuso <pablo@netfilter.org>, devel@driverdev.osuosl.org, Albert Ou <aou@eecs.berkeley.edu>, Johannes Berg <johannes.berg@intel.com>, Intel Linux Wireless <linuxwifi@intel.com>, linux-kbuild@vger.kernel.org, "James E.J. Bottomley" <jejb@linux.ibm.com>, Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, linuxppc-dev@lists.ozlabs.org, Mauro Carvalho Chehab <mchehab@infradead.org>, adead.or, openrisc@lists.librecores.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Greentime Hu <green.hu@gmail.com>, linux-mtd@lists.infradead.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Kalle Valo <kvalo@codeaurora.org>, Jon Maloy <jon.maloy@ericsson.com>, Michal Simek <monstr@monstr.eu>, Michal Marek <michal.lkml@markovi.net>, Nikolay Aleksandrov <nikolay@cumulusnetworks.>, Teddy Wang <teddy.wang@siliconmotion.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Vineet Gupta <vgupta@synopsys.com>, linux-usb@vger.kernel.org, Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, netfilter-devel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Ying Xue <ying.xue@windriver.com>, Luca Coelho <luciano.coelho@intel.com>, Brian Norris <computersforpeace@gmail.com>, com, "David S. Miller" <davem@davemloft.net>

In data Sunday, June 9, 2019 4:27:04 AM CEST, Mauro Carvalho Chehab ha 
scritto:
> The kbuild documentation clearly shows that the documents
> there are written at different times: some use markdown,
> some use their own peculiar logic to split sections.
> 
> Convert everything to ReST without affecting too much
> the author's style and avoiding adding uneeded markups.
> 
> The conversion is actually:
>   - add blank lines and identation in order to identify paragraphs;
>   - fix tables markups;
>   - add some lists markups;
>   - mark literal blocks;
>   - adjust title markups.
> 
> At its new index.rst, let's add a :orphan: while this is not linked to
> the main index.rst file, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/admin-guide/README.rst          |   2 +-
>  ...eaders_install.txt => headers_install.rst} |   5 +-
>  Documentation/kbuild/index.rst                |  27 +
>  Documentation/kbuild/issues.rst               |  11 +
>  .../kbuild/{kbuild.txt => kbuild.rst}         | 119 ++--
>  ...nfig-language.txt => kconfig-language.rst} | 232 ++++----
>  ...anguage.txt => kconfig-macro-language.rst} |  37 +-
>  .../kbuild/{kconfig.txt => kconfig.rst}       | 136 +++--
>  .../kbuild/{makefiles.txt => makefiles.rst}   | 530 +++++++++++-------
>  .../kbuild/{modules.txt => modules.rst}       | 168 +++---
>  Documentation/kernel-hacking/hacking.rst      |   4 +-
>  Documentation/process/coding-style.rst        |   2 +-
>  Documentation/process/submit-checklist.rst    |   2 +-
>  .../it_IT/kernel-hacking/hacking.rst          |   4 +-
>  .../it_IT/process/coding-style.rst            |   2 +-
>  .../it_IT/process/submit-checklist.rst        |   2 +-

Limited to translations/it_IT

Acked-by: Federico Vaga <federico.vaga@vaga.pv.it>

>  .../zh_CN/process/coding-style.rst            |   2 +-
>  .../zh_CN/process/submit-checklist.rst        |   2 +-
>  Kconfig                                       |   2 +-
>  arch/arc/plat-eznps/Kconfig                   |   2 +-
>  arch/c6x/Kconfig                              |   2 +-
>  arch/microblaze/Kconfig.debug                 |   2 +-
>  arch/microblaze/Kconfig.platform              |   2 +-
>  arch/nds32/Kconfig                            |   2 +-
>  arch/openrisc/Kconfig                         |   2 +-
>  arch/powerpc/sysdev/Kconfig                   |   2 +-
>  arch/riscv/Kconfig                            |   2 +-
>  drivers/auxdisplay/Kconfig                    |   2 +-
>  drivers/firmware/Kconfig                      |   2 +-
>  drivers/mtd/devices/Kconfig                   |   2 +-
>  drivers/net/ethernet/smsc/Kconfig             |   6 +-
>  drivers/net/wireless/intel/iwlegacy/Kconfig   |   4 +-
>  drivers/net/wireless/intel/iwlwifi/Kconfig    |   2 +-
>  drivers/parport/Kconfig                       |   2 +-
>  drivers/scsi/Kconfig                          |   4 +-
>  drivers/staging/sm750fb/Kconfig               |   2 +-
>  drivers/usb/misc/Kconfig                      |   4 +-
>  drivers/video/fbdev/Kconfig                   |  14 +-
>  net/bridge/netfilter/Kconfig                  |   2 +-
>  net/ipv4/netfilter/Kconfig                    |   2 +-
>  net/ipv6/netfilter/Kconfig                    |   2 +-
>  net/netfilter/Kconfig                         |  16 +-
>  net/tipc/Kconfig                              |   2 +-
>  scripts/Kbuild.include                        |   4 +-
>  scripts/Makefile.host                         |   2 +-
>  scripts/kconfig/symbol.c                      |   2 +-
>  .../tests/err_recursive_dep/expected_stderr   |  14 +-
>  sound/oss/dmasound/Kconfig                    |   6 +-
>  48 files changed, 840 insertions(+), 561 deletions(-)
>  rename Documentation/kbuild/{headers_install.txt => headers_install.rst}
> (96%) create mode 100644 Documentation/kbuild/index.rst
>  create mode 100644 Documentation/kbuild/issues.rst
>  rename Documentation/kbuild/{kbuild.txt => kbuild.rst} (72%)
>  rename Documentation/kbuild/{kconfig-language.txt => kconfig-language.rst}
> (85%) rename Documentation/kbuild/{kconfig-macro-language.txt =>
> kconfig-macro-language.rst} (94%) rename Documentation/kbuild/{kconfig.txt
> => kconfig.rst} (80%)
>  rename Documentation/kbuild/{makefiles.txt => makefiles.rst} (83%)
>  rename Documentation/kbuild/{modules.txt => modules.rst} (84%)





