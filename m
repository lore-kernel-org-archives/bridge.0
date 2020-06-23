Return-Path: <borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
Message-ID: <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200623141157.5409-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] linux-next: umh: fix processed error when
 UMH_WAIT_PROC is used seems to break linux bridge on s390x (bisected)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 23 Jun 2020 15:09:04 -0000
To: mcgrof@kernel.org
Cc: ast@kernel.org, jarkko.sakkinen@linux.intel.com, philipp.reisner@linbit.com, dhowells@redhat.com, keyrings@vger.kernel.org, christian.brauner@ubuntu.com, yangtiezhu@loongson.cn, linux-s390 <linux-s390@vger.kernel.org>, bridge@lists.linux-foundation.org, jmorris@namei.org, kuba@kernel.org, serge@hallyn.com, keescook@chromium.org, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, josh@joshtriplett.org, slyfox@gentoo.org, viro@zeniv.linux.org.uk, axboe@kernel.dk, bfields@fieldses.org, linux-nfs@vger.kernel.org, chainsaw@gentoo.org, ravenexp@gmail.com, gregkh@linuxfoundation.org, markward@linux.ibm.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, chuck.lever@oracle.com, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, lars.ellenberg@linbit.com, davem@davemloft.net



On 23.06.20 16:11, Christian Borntraeger wrote:
> Jens Markwardt reported a regression in the linux-next runs.  with "umh: fix
> processed error when UMH_WAIT_PROC is used" (from linux-next) a linux bridge
> with an KVM guests no longer activates :
> 
> without patch
> # ip addr show dev virbr1
> 6: virbr1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
>        valid_lft forever preferred_lft forever
> 
> with this patch the bridge stays DOWN with NO-CARRIER
> 
> # ip addr show dev virbr1
> 6: virbr1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
>        valid_lft forever preferred_lft forever
> 
> This was bisected in linux-next. Reverting from linux-next also fixes the issue.
> 
> Any idea?

FWIW, s390 is big endian. Maybe some of the shifts inn the __KW* macros are wrong.
