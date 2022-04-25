Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:subject:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eSUUmvcNxUREKY9cfIXBqiFcqq7TWxDWmLrdLzNKTdU=;
 b=EKZUOtERmjlzbXufW4645zt3AX8Dp81DRfEiYA6+kWUhMRR3qkn/JamkKu2b/Ny02G
 dlBxN7CY3TxY4t8SdfHJjGd9T40h8MUEY0AImsXJSW8/ZkiqTEwuUGF5R2KbsXfWuSVf
 kOosTDhAkaDOuvuD9E/k+TGdqPErzhC7wMl7JVDA7xOuTI4XUVawX8+S5ooCIZCa63yE
 fEysmS1mtk4vLSpOJFLMcp+faGnMhiGs0OxF4NeFm+SnkOAxvb0MsBIbPoooIjtpYPhS
 XRpiPiwHTdTuUQUChwjTg5iwy75JYVBxk+Z1aQvvZ/XAvJnezxMv1PVxk/uDfLz7Q0Ew
 Q+VQ==
Date: Mon, 25 Apr 2022 09:06:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20220425090649.1b99fade@hermes.local>
In-Reply-To: <a99bfeb371857968a3fa734c00bd9b0e122719c1.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
 <a99bfeb371857968a3fa734c00bd9b0e122719c1.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 2/2] net: vxlan: vxlan_core.c: Add
 extack support to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Mon, 25 Apr 2022 16:25:07 +0200
Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com> wrote:

>  static int vxlan_fdb_parse(struct nlattr *tb[], struct vxlan_dev *vxlan,
>  			   union vxlan_addr *ip, __be16 *port, __be32 *src_vni,
> -			   __be32 *vni, u32 *ifindex, u32 *nhid)
> +			   __be32 *vni, u32 *ifindex, u32 *nhid, struct netlink_ext_ack *extack)
>  {
>  	struct net *net = dev_net(vxlan->dev);
>  	int err;
> 
>  	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
> -	    tb[NDA_PORT]))
> -		return -EINVAL;
> +	    tb[NDA_PORT])) {
> +			NL_SET_ERR_MSG(extack,
> +						   "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
> +			return -EINVAL;
> +		}

The indentation is off here?
