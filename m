Return-Path: <stephen@networkplumber.org>
Date: Mon, 20 Jul 2015 15:28:17 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150720152817.4c2f5c73@urahara>
In-Reply-To: <1436540528-42334-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1436540528-42334-1-git-send-email-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mdb: add vlan support for
	user entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net

On Fri, 10 Jul 2015 08:02:08 -0700
Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> index eaaea6208b42..3635b7797508 100644
> --- a/include/uapi/linux/if_bridge.h
> +++ b/include/uapi/linux/if_bridge.h
> @@ -182,6 +182,7 @@ struct br_mdb_entry {
>  #define MDB_TEMPORARY 0
>  #define MDB_PERMANENT 1
>  	__u8 state;
> +	__u16 vid;
>  	struct {
>  		union {
>  			__be32	ip4;

You added a new field into an unused hole in a data
structure shared as part of API with user space.

This seems like it might break when newer iproute
is run on older kernels. The vid would always be 0
on show and ignored when adding entries.

