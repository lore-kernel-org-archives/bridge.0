Message-ID: <47D3ED21.6050903@operations.com>
Date: Sun, 09 Mar 2008 09:58:57 -0400
From: Lou Steinberg <lspam5@operations.com>
MIME-Version: 1.0
References: <47D05B55.404@operations.com>
	<2e59e6970803082338n20c9037p6ccae93654c58a69@mail.gmail.com>
In-Reply-To: <2e59e6970803082338n20c9037p6ccae93654c58a69@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge-utils and ppp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Cc: bridge@lists.linux-foundation.org

Hi Richard-

[snip]
> 
> Does a bridge "test" exist?  What is the output of brctl show?
> 
[snip]

Yes, the bridge exists.  brctl shows:

 > root@wan-bridge:~$ brctl addif test ppp0
 > can't add ppp0 to bridge test: Invalid argument
 > root@wan-bridge:~$ echo $?
 > 1
 > root@wan-bridge:~$ brctl show
 > bridge name     bridge id               STP enabled     interfaces
 > test            8000.000000000000       no

Thanks,
Lou
