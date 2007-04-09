Date: Mon, 9 Apr 2007 11:55:20 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070409115520.20b92114@dxpl.pdx.osdl.net>
In-Reply-To: <20070407095707.GC4660@APFDCB5C>
References: <20070407095707.GC4660@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: check kmem_cache_create() error
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: bridge@lists.osdl.org

On Sat, 7 Apr 2007 18:57:07 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This patch checks kmem_cache_create() error and aborts loading module
> on failure.
> 
> Cc: Stephen Hemminger <shemminger@linux-foundation.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> 

applied for 2.6.22 update bundle
